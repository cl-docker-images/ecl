#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
FROM debian:buster

ENV ECL_COMMIT e68e68278448172abae68b9756659d113d93dbf4

WORKDIR /usr/local/src/

# hadolint ignore=DL3003,DL3008,DL4006
RUN set -x \
    && case "$(dpkg --print-architecture)" in \
    # Needed when building 32 bit arm on 64-bit host.
    armhf) export build="--build=arm-linux-gnueabihf";; \
    esac \
    && apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates build-essential gcc m4 file \
    && curl -L https://gitlab.com/embeddable-common-lisp/ecl/-/archive/$ECL_COMMIT/ecl-$ECL_COMMIT.tar.gz > ecl-${ECL_COMMIT}.tgz \
    && gunzip ecl-${ECL_COMMIT}.tgz \
    && tar xf ecl-${ECL_COMMIT}.tar \
    && (cd ecl-${ECL_COMMIT} && ./configure --disable-manual $build && make -j $(nproc) && make install) \
    && rm -rf ecl-${ECL_COMMIT}.tar ecl-${ECL_COMMIT} \
    && apt-get remove -y curl ca-certificates build-essential m4 file \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && ecl --version

WORKDIR /

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["ecl"]
