#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
FROM alpine:3.14

ENV ECL_VERSION 21.2.1
ENV ECL_SHA512 0849bebe1a8073ea8027cfb172c1d7781d43adb6a8b80585bd08d5674b80422d1648b6fbf718cc17a51c5de6c696514523b4d13a82e8113bf9365c95d3c28648

WORKDIR /usr/local/src/

# hadolint ignore=DL3003,DL3018,DL4006
RUN set -x \
    && case "$(cat /etc/apk/arch)" in \
    # Needed when building 32 bit arm on 64-bit host.
    armv7) export build="--build=arm-linux-gnueabihf";; \
    esac \
    && apk add --no-cache ca-certificates curl openssl make gcc musl-dev linux-headers \
                          gmp-dev libffi-dev \
    && curl -L https://common-lisp.net/project/ecl/static/files/release/ecl-${ECL_VERSION}.tgz > ecl-${ECL_VERSION}.tgz \
    && echo "$ECL_SHA512  ecl-${ECL_VERSION}.tgz" | sha512sum -c \
    && gunzip ecl-${ECL_VERSION}.tgz \
    && tar xf ecl-${ECL_VERSION}.tar \
    && (cd ecl-${ECL_VERSION} && ./configure --disable-manual $build && make -j $(nproc) && make install) \
    && rm -rf ecl-${ECL_VERSION}.tar ecl-${ECL_VERSION} \
    && apk del --no-cache ca-certificates curl openssl make

WORKDIR /

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["ecl"]
