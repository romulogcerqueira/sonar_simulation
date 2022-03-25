FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu18.04
LABEL maintainer "Rômulo Cerqueira <romulogcerqueira@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update > /dev/null 2>&1 && \
    apt-get install -y software-properties-common > /dev/null 2>&1 && \
    add-apt-repository ppa:brightbox/ruby-ng > /dev/null 2>&1 && \
    apt-get update && apt-get install -y --no-install-recommends \
        apt-utils \
        bash-completion \
        build-essential \
        curl \
        git \
        locales \
        pkg-config \
        ruby2.5 \
        ruby2.5-dev \
        ssh-client \
        sudo \
        tzdata \
        wget > /dev/null 2>&1 && \
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get install -y git-lfs > /dev/null 2>&1 && \
    apt-get clean && \
    echo "Binary::apt::APT::Keep-Downloaded-Packages \"true\";" | tee /etc/apt/apt.conf.d/bir-keep-cache && \
    rm -rf /etc/apt/apt.conf.d/docker-clean && \
    rm -rf /tmp/* /var/tmp/*

# Set env variables
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    QT_X11_NO_MITSHM=1

# Replicate host user to the docker image
ARG USERNAME
ARG UUID
ARG UGID

RUN useradd -m ${USERNAME} && \
    echo "${USERNAME}:${USERNAME}" | chpasswd && \
    usermod --shell /bin/bash ${USERNAME} && \
    usermod -aG sudo ${USERNAME} && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/${USERNAME} && \
    chmod 0440 /etc/sudoers.d/${USERNAME} && \
    usermod --uid ${UUID} ${USERNAME} && \
    groupmod --gid ${UGID} ${USERNAME}

# Copy scripts to docker image
COPY rootfs/ /

RUN chmod 755 /usr/bin/install-autoproj && \
    chmod 755 /usr/bin/bootstrap-project && \
    chmod 755 /usr/bin/install-workspace && \
    chmod 755 /usr/bin/reset-omniorb && \
    chmod 755 /usr/bin/install-sonarsim

CMD ["/bin/bash"]
