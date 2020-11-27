#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
FROM alpine:3.12

ENV ECL_VERSION TEMPLATE
ENV ECL_SHA512 TEMPLATE

WORKDIR /usr/local/src/

# hadolint ignore=DL3003,DL3018,DL4006
RUN set -x \
    && apk add --no-cache ca-certificates curl openssl make gcc musl-dev linux-headers \
                          gmp-dev libffi-dev \
    && curl -L https://common-lisp.net/project/ecl/static/files/release/ecl-${ECL_VERSION}.tgz > ecl-${ECL_VERSION}.tgz \
    && echo "$ECL_SHA512  ecl-20.4.24.tgz" | sha512sum -c \
    && gunzip ecl-${ECL_VERSION}.tgz \
    && tar xf ecl-${ECL_VERSION}.tar \
    && (cd ecl-${ECL_VERSION} && ./configure --disable-manual && make -j $(nproc) && make install) \
    && rm -rf ecl-${ECL_VERSION}.tar ecl-${ECL_VERSION} \
    && apk del --no-cache ca-certificates curl openssl make

WORKDIR /

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["ecl"]
