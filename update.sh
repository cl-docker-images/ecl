#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

declare -A refs=(
    [22.0.0-rc]='develop'
)

versions=( "$@" )

generated_warning() {
    cat <<EOH
#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
EOH
}

for version in "${versions[@]}"; do

    if [[ $version == *rc ]]; then
        eclGitSha="$(curl -fsSL "https://gitlab.com/api/v4/projects/embeddable-common-lisp%2Fecl/repository/branches/${refs[$version]}" | jq -r .commit.id)"
        unset sbclSourceUrl
        unset sbclSourceSha
    else
        unset eclGitSha
        eclSourceUrl="https://common-lisp.net/project/ecl/static/files/release/ecl-$version.tgz"
        eclSourceSha="$(curl -fsSL "$eclSourceUrl" | sha512sum | cut -d' ' -f1)"
    fi

    for v in \
        bullseye/{,slim} \
        buster/{,slim} \
        alpine3.14/ \
        alpine3.13/ \
    ; do
        os="${v%%/*}"
        variant="${v#*/}"
        dir="$version/$v"

        if [[ $version == *rc ]] && [[ "$os" == "windowsservercore"* ]]; then
            continue
        fi

        mkdir -p "$dir"

        case "$os" in
            bullseye|buster|stretch)
                template="apt"
                if [ "$variant" = "slim" ]; then
                    from="debian:$os"
                else
                    from="buildpack-deps:$os"
                    cp install-quicklisp "$dir/install-quicklisp"
                fi
                cp docker-entrypoint.sh "$dir/docker-entrypoint.sh"
                ;;
            alpine*)
                template="apk"
                cp docker-entrypoint.sh "$dir/docker-entrypoint.sh"
                from="alpine:${os#alpine}"
                ;;
            windowsservercore-*)
                template='windowsservercore'
                from="mcr.microsoft.com/windows/servercore:${os#*-}"
                ;;
        esac

        if [ -n "$variant" ]; then
            template="$template-$variant"
        fi

        if [[ $version == *rc ]]; then
            template="$template-nightly"
        fi

        template="Dockerfile-${template}.template"

        { generated_warning; cat "$template"; } > "$dir/Dockerfile"

        if [[ $version == *rc ]]; then
            sed -ri \
                -e 's,^(FROM) .*,\1 '"$from"',' \
                -e 's/^(ENV ECL_COMMIT) .*/\1 '"$eclGitSha"'/' \
                "$dir/Dockerfile"
        else
            sed -ri \
                -e 's/^(ENV ECL_VERSION) .*/\1 '"$version"'/' \
                -e 's/^(ENV ECL_SHA512) .*/\1 '"$eclSourceSha"'/' \
                -e 's,^(FROM) .*,\1 '"$from"',' \
                "$dir/Dockerfile"
        fi
    done
done
