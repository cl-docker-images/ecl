#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
FROM alpine:3.12

ENV ECL_COMMIT a7e1bf6c9f2a77fd47f63382a9d8372bc1a15e34

WORKDIR /usr/local/src/

# hadolint ignore=DL3003,DL3018,DL4006
RUN set -x \
    && case "$(cat /etc/apk/arch)" in \
    # Needed when building 32 bit arm on 64-bit host.
    armv7) export build="--build=arm-linux-gnueabihf";; \
    esac \
    && apk add --no-cache ca-certificates curl openssl make gcc musl-dev linux-headers \
                          gmp-dev libffi-dev \
    && curl -L https://gitlab.com/embeddable-common-lisp/ecl/-/archive/$ECL_COMMIT/ecl-$ECL_COMMIT.tar.gz > ecl-${ECL_COMMIT}.tgz \
    && gunzip ecl-${ECL_COMMIT}.tgz \
    && tar xf ecl-${ECL_COMMIT}.tar \
    && (cd ecl-${ECL_COMMIT} && ./configure --disable-manual $build && make -j $(nproc) && make install) \
    && rm -rf ecl-${ECL_COMMIT}.tar ecl-${ECL_COMMIT} \
    && apk del --no-cache ca-certificates curl openssl make

WORKDIR /

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["ecl"]
