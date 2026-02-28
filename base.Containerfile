FROM quay.io/fedora/fedora-bootc:latest AS builder
ARG TARGETARCH='amd64'

RUN /usr/libexec/bootc-base-imagectl build-rootfs --manifest=fedora-minimal /target-rootfs
FROM scratch
COPY --from=builder /target-rootfs/ /
COPY overlay.d/01-common/ /
RUN <<EOF
set -xeuo pipefail
dnf clean all && rm -rf /var/cache/dnf
bootc container lint
EOF
LABEL containers.bootc 1
LABEL ostree.bootable 1

STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
