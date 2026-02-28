FROM ghcr.io/matchascript/fedora-bootc:base-amd64
RUN dnf install -y hyperv-daemons && \
    dnf clean all
RUN systemctl enable hypervfcopyd && \
    systemctl enable hypervkvpd && \
    systemctl enable hypervvssd

RUN rm /var/{log,cache,lib}/* -rf
RUN bootc container lint
