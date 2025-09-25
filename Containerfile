FROM quay.io/centos/centos:stream9
RUN dnf install -y epel-release && \
    /usr/bin/crb enable && \
    dnf copr enable -y lihaohong/bazel && \
    dnf copr enable -y pingou/score-playground && \
    dnf install -y bazel git score-baselibs score-baselibs-devel make gcc-c++ patch libacl-devel boost-devel json-devel google-benchmark-devel vim rsync rpm-build libcap-devel

RUN mkdir -p ~/rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}

WORKDIR /workspace
COPY . /workspace
USER root
