# -*- mode: dockerfile -*-
FROM alpine:3.19

ARG REVISION=unknown
ARG IMAGE_CREATED
ARG COMPILER_VERSION=5.1.1

# https://github.com/opencontainers/image-spec/blob/main/annotations.md
LABEL org.opencontainers.image.base.name=alpine:3.19
LABEL org.opencontainers.image.source=https://github.com/rbjorklin/techempower-ocaml-image
LABEL org.opencontainers.image.revision=${REVISION}
LABEL org.opencontainers.image.created=${IMAGE_CREATED}

# https://caml.inria.fr/pub/docs/manual-ocaml/libref/Gc.html
# https://linux.die.net/man/1/ocamlrun
# https://blog.janestreet.com/memory-allocator-showdown/
ENV OCAMLRUNPARAM a=2,o=240

# https://blog.packagecloud.io/eng/2017/02/21/set-environment-variable-save-thousands-of-system-calls/
ENV TZ  :/etc/localtime

ENV PKGS atd \
    atdgen \
    atdgen-runtime \
    biniou\
    caqti-driver-postgresql\
    caqti-lwt\
    caqti\
    cohttp-lwt-unix\
    conf-libev \
    dune \
    httpaf \
    httpaf-lwt-unix \
    lwt \
    lwt_ppx\
    opium \
    ppx_deriving_yojson \
    ppx_rapper \
    ppx_rapper_lwt \
    tyxml \
    webmachine\
    yojson

RUN apk add --no-cache \
    bash\
    bubblewrap\
    coreutils\
    gcc\
    git\
    gmp-dev\
    libev\
    libev-dev\
    libffi-dev\
    linux-headers\
    m4\
    make\
    musl-dev\
    opam\
    postgresql-dev\
    zstd-dev

RUN opam init\
    --disable-sandboxing\
    --auto-setup\
    --compiler ocaml-base-compiler.${COMPILER_VERSION}

  #opam install --depext-only -y $PKGS && \
RUN \
  opam install --no-depexts -y $PKGS
