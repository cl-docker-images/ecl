- [Supported Tags](#org30e73eb)
- [Quick Reference](#orgf2f81da)
- [What is ECL?](#orgb32911f)
- [What's in the image?](#org856697d)
- [License](#org33d8e3a)



<a id="org30e73eb"></a>

# Supported Tags

-   `20.4.24-alpine3.12`, `20.4.24-alpine`, `alpine3.12`, `alpine`
-   `20.4.24-alpine3.11`, `alpine3.11`
-   `20.4.24-buster`, `20.4.24`, `buster`, `latest`
-   `20.4.24-stretch`, `stretch`


<a id="orgf2f81da"></a>

# Quick Reference

-   **ECL Home Page:** <https://common-lisp.net/project/ecl/>
-   **Where to file Docker image related issues:** <https://gitlab.common-lisp.net/cl-docker-images/ecl>
-   **Where to file issues for ECL itself:** <https://gitlab.com/embeddable-common-lisp/ecl>
-   **Maintained by:** [Eric Timmons](https://github.com/daewok/) and the [MIT MERS Group](https://mers.csail.mit.edu/) (i.e., this is not an official ECL image)
-   **Supported architectures:** `linux/amd64`, `linux/arm64`, `linux/arm/v7`


<a id="orgb32911f"></a>

# What is ECL?

From [ECL's Home Page](https://common-lisp.net/project/ecl/main.html):

> ECL (Embeddable Common-Lisp) is an interpreter of the Common-Lisp language as described in the X3J13 Ansi specification, featuring CLOS (Common-Lisp Object System), conditions, loops, etc, plus a translator to C, which can produce standalone executables.
>
> ECL supports the operating systems Linux, FreeBSD, NetBSD, OpenBSD, OS X, Solaris, Windows, iOS and Android, running on top of the Intel, Sparc, Alpha, PowerPC and ARM processors.


<a id="org856697d"></a>

# What's in the image?

This image contains ECL binaries built from the latest source releases from the ECL devs for a variety of OSes and architectures.


<a id="org33d8e3a"></a>

# License

ECL is mostly licensed under the [GNU LGPL v2+](https://opensource.org/licenses/LGPL-2.0).

The Dockerfiles used to build the images are licensed under BSD-2-Clause.

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.
