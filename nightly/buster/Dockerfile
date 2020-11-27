#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
FROM buildpack-deps:buster

ENV ECL_COMMIT 6ff3b2b86b4bfff6af3be04da0c84563a55a595d

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
    && (cd ecl-${ECL_COMMIT} && ./configure --disable-manual $build && make -j $(nproc) && make install) \
    && rm -rf ecl-${ECL_COMMIT}.tar ecl-${ECL_COMMIT} \
    && ecl --version

WORKDIR /

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["ecl"]
