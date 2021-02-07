#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
FROM buildpack-deps:stretch

ENV ECL_COMMIT 2a1441484e25a7351e1cd66b9e8c5a7217510121

WORKDIR /usr/local/src/

# hadolint ignore=DL3003,DL3008,DL4006
RUN set -x \
    && case "$(dpkg --print-architecture)" in \
    # Needed when building 32 bit arm on 64-bit host.
    armhf) export build="--build=arm-linux-gnueabihf";; \
    esac \
    && curl -L https://gitlab.com/embeddable-common-lisp/ecl/-/archive/$ECL_COMMIT/ecl-$ECL_COMMIT.tar.gz > ecl-${ECL_COMMIT}.tgz \
    && gunzip ecl-${ECL_COMMIT}.tgz \
    && tar xf ecl-${ECL_COMMIT}.tar \
    && mv ecl-$ECL_COMMIT ecl \
    && (cd ecl && ./configure --disable-manual $build && make -j $(nproc) && make install && make clean ) \
    && rm -rf ecl-${ECL_COMMIT}.tar \
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

# Add the script to trivially install Quicklisp
COPY install-quicklisp /usr/local/bin/install-quicklisp

# Add the entrypoint
WORKDIR /

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["ecl"]
