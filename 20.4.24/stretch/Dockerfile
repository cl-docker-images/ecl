#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
FROM buildpack-deps:stretch

ENV ECL_VERSION 20.4.24
ENV ECL_SHA512 4c127e0d6a99e38f3a926135ae92d92899058c5a5e99b90f28d4a47b58d94ee89a958cfb4bfd2b9e6ad7b3c57867cd13119b2a4dd6bb1aa3bb5ec42a96bfa788

WORKDIR /usr/local/src/

# hadolint ignore=DL3003,DL3008,DL4006
RUN set -x \
    && case "$(dpkg --print-architecture)" in \
    # Needed when building 32 bit arm on 64-bit host.
    armhf) export build="--build=arm-linux-gnueabihf";; \
    esac \
    && curl -L https://common-lisp.net/project/ecl/static/files/release/ecl-${ECL_VERSION}.tgz > ecl-${ECL_VERSION}.tgz \
    && echo "$ECL_SHA512  ecl-20.4.24.tgz" | sha512sum -c \
    && gunzip ecl-${ECL_VERSION}.tgz \
    && tar xf ecl-${ECL_VERSION}.tar \
    && mv ecl-${ECL_VERSION} ecl \
    && (cd ecl && ./configure --disable-manual $build && make -j $(nproc) && make install && make clean ) \
    && rm -rf ecl-${ECL_VERSION}.tar \
    && ecl --version

# Add the Quicklisp installer.
WORKDIR /usr/local/share/common-lisp/source/quicklisp/

ENV QUICKLISP_SIGNING_KEY D7A3489DDEFE32B7D0E7CC61307965AB028B5FF7

RUN set -x \
    && curl -fsSL "https://beta.quicklisp.org/quicklisp.lisp" > quicklisp.lisp \
    && curl -fsSL "https://beta.quicklisp.org/quicklisp.lisp.asc" > quicklisp.lisp.asc \
    && GNUPGHOME="$(mktemp -d)" \
    && export GNUPGHOME \
    && gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys "${QUICKLISP_SIGNING_KEY}" \
    && gpg --batch --verify "quicklisp.lisp.asc" "quicklisp.lisp" \
    && rm quicklisp.lisp.asc \
    && rm -rf "$GNUPGHOME"

# Add the entrypoint
WORKDIR /

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["ecl"]
