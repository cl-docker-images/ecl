#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
FROM debian:stretch

ENV ECL_VERSION 20.4.24
ENV ECL_SHA512 4c127e0d6a99e38f3a926135ae92d92899058c5a5e99b90f28d4a47b58d94ee89a958cfb4bfd2b9e6ad7b3c57867cd13119b2a4dd6bb1aa3bb5ec42a96bfa788

WORKDIR /usr/local/src/

# hadolint ignore=DL3003,DL3008,DL4006
RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates build-essential gcc m4 file \
    && curl -L https://common-lisp.net/project/ecl/static/files/release/ecl-${ECL_VERSION}.tgz > ecl-${ECL_VERSION}.tgz \
    && echo "$ECL_SHA512  ecl-20.4.24.tgz" | sha512sum -c \
    && gunzip ecl-${ECL_VERSION}.tgz \
    && tar xf ecl-${ECL_VERSION}.tar \
    && (cd ecl-${ECL_VERSION} && ./configure --disable-manual && make && make install) \
    && rm -rf ecl-${ECL_VERSION}.tar ecl-${ECL_VERSION} \
    && apt-get remove -y curl ca-certificates build-essential m4 file \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && ecl --version

WORKDIR /

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["ecl"]
