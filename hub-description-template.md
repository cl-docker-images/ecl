- [Supported Tags](#orgc84b322)
  - [Simple Tags](#org437ab44)
  - [Shared Tags](#org8ac9073)
- [Quick Reference](#org7b197a4)
- [What is ECL?](#org77f1ee8)
- [How to use this iamge](#orgf38b96e)
  - [Create a `Dockerfile` in your ECL project](#orge931df3)
  - [Run a single Common Lisp script](#org4b47cba)
  - [Developing using SLIME](#org73328fc)
- [What's in the image?](#org38fc686)
- [Image variants](#org6d7ea22)
  - [`%%IMAGE%%:<version>`](#org7191ecb)
  - [`%%IMAGE%%:<version>-slim`](#org3da4001)
  - [`%%IMAGE%%:<version>-alpine`](#org824a07a)
- [License](#org47321bd)



<a id="orgc84b322"></a>

# Supported Tags


<a id="org437ab44"></a>

## Simple Tags

INSERT-SIMPLE-TAGS


<a id="org8ac9073"></a>

## Shared Tags

INSERT-SHARED-TAGS


<a id="org7b197a4"></a>

# Quick Reference

-   **ECL Home Page:** <https://common-lisp.net/project/ecl/>
-   **Where to file Docker image related issues:** <https://gitlab.common-lisp.net/cl-docker-images/ecl>
-   **Where to file issues for ECL itself:** <https://gitlab.com/embeddable-common-lisp/ecl>
-   **Maintained by:** [Eric Timmons](https://github.com/daewok/)
-   **Supported architectures:** `linux/amd64`, `linux/arm64`, `linux/arm/v7`


<a id="org77f1ee8"></a>

# What is ECL?

From [ECL's Home Page](https://common-lisp.net/project/ecl/main.html):

> ECL (Embeddable Common-Lisp) is an interpreter of the Common-Lisp language as described in the X3J13 Ansi specification, featuring CLOS (Common-Lisp Object System), conditions, loops, etc, plus a translator to C, which can produce standalone executables.
> 
> ECL supports the operating systems Linux, FreeBSD, NetBSD, OpenBSD, OS X, Solaris, Windows, iOS and Android, running on top of the Intel, Sparc, Alpha, PowerPC and ARM processors.


<a id="orgf38b96e"></a>

# How to use this iamge


<a id="orge931df3"></a>

## Create a `Dockerfile` in your ECL project

```dockerfile
FROM %%IMAGE%%:latest
COPY . /usr/src/app
WORKDIR /usr/src/app
CMD [ "ecl", "--load", "./your-daemon-or-script.lisp" ]
```

You can then build and run the Docker image:

```console
$ docker build -t my-ecl-app
$ docker run -it --rm --name my-running-app my-ecl-app
```


<a id="org4b47cba"></a>

## Run a single Common Lisp script

For many simple, single file projects, you may find it inconvenient to write a complete \`Dockerfile\`. In such cases, you can run a Lisp script by using the ECL Docker image directly:

```console
$ docker run -it --rm --name my-running-script -v "$PWD":/usr/src/app -w /usr/src/app %%IMAGE%%:latest ecl --load ./your-daemon-or-script.lisp
```


<a id="org73328fc"></a>

## Developing using SLIME

[SLIME](https://common-lisp.net/project/slime/) provides a convenient and fun environment for hacking on Common Lisp. To develop using SLIME, first start the Swank server in a container:

```console
$ docker run -it --rm --name ecl-slime -p 127.0.0.1:4005:4005 -v /path/to/slime:/usr/src/slime -v "$PWD":/usr/src/app -w /usr/src/app %%IMAGE%%:latest ecl --load /usr/src/slime/swank-loader.lisp --eval '(swank-loader:init)' --eval '(swank:create-server :dont-close t :interface "0.0.0.0")'
```

Then, in an Emacs instance with slime loaded, type:

```emacs
M-x slime-connect RET RET RET
```


<a id="org38fc686"></a>

# What's in the image?

This image contains ECL binaries built from the latest source releases from the ECL devs for a variety of OSes and architectures.


<a id="org6d7ea22"></a>

# Image variants

This image comes in several variants, each designed for a specific use case.


<a id="org7191ecb"></a>

## `%%IMAGE%%:<version>`

This is the defacto image. If you are unsure about what your needs are, you probably want to use this one. It is designed to be used both as a throw away container (mount your source code and start the container to start your app), as well as the base to build other images off of. Additionally, these images contain the ECL source code (at `/usr/local/src/ecl`) to help facilitate interactive development and exploration (a hallmark of Common Lisp!).

Some of these tags may have names like buster or stretch in them. These are the suite code names for releases of Debian and indicate which release the image is based on. If your image needs to install any additional packages beyond what comes with the image, you'll likely want to specify one of these explicitly to minimize breakage when there are new releases of Debian.

These images are built off the buildpack-deps image. It, by design, has a large number of extremely common Debian packages.

These images contain the Quicklisp installer, located at `/usr/local/share/common-lisp/source/quicklisp/quicklisp.lisp`.


<a id="org3da4001"></a>

## `%%IMAGE%%:<version>-slim`

This image does not contain the common packages contained in the default tag and only contains the minimal packages needed to run ECL. Unless you are working in an environment where only this image will be deployed and you have space constraints, we highly recommend using the default image of this repository.


<a id="org824a07a"></a>

## `%%IMAGE%%:<version>-alpine`

This image is based on the popular [Alpine Linux project](https://alpinelinux.org/), available in [the `alpine` official image](https://hub.docker.com/_/alpine). Alpine Linux is much smaller than most distribution base images (~5MB), and thus leads to much slimmer images in general.

This variant is highly recommended when final image size being as small as possible is desired. The main caveat to note is that it does use [musl libc](https://musl.libc.org/) instead of [glibc and friends](https://www.etalabs.net/compare_libcs.html), so certain software might run into issues depending on the depth of their libc requirements. However, most software doesn't have an issue with this, so this variant is usually a very safe choice. See [this Hacker News comment thread](https://news.ycombinator.com/item?id=10782897) for more discussion of the issues that might arise and some pro/con comparisons of using Alpine-based images.

To minimize image size, it's uncommon for additional related tools (such as git or bash) to be included in Alpine-based images. Using this image as a base, add the things you need in your own Dockerfile (see the [alpine image description](https://hub.docker.com/_/alpine/) for examples of how to install packages if you are unfamiliar).


<a id="org47321bd"></a>

# License

ECL is mostly licensed under the [GNU LGPL v2+](https://opensource.org/licenses/LGPL-2.0).

The Dockerfiles used to build the images are licensed under BSD-2-Clause.

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.
