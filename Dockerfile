FROM ubuntu:latest

RUN apt-get update \
    && echo "Install podman" \
    && apt-get -y install gpg lsb-release curl \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://download.opensuse.org/repositories/devel:kubic:libcontainers:unstable/xUbuntu_$(lsb_release -rs)/Release.key \
    | gpg --dearmor \
    | tee /etc/apt/keyrings/devel_kubic_libcontainers_unstable.gpg > /dev/null \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/devel_kubic_libcontainers_unstable.gpg] https://download.opensuse.org/repositories/devel:kubic:libcontainers:unstable/xUbuntu_$(lsb_release -rs)/ /" \
    | tee /etc/apt/sources.list.d/devel:kubic:libcontainers:unstable.list > /dev/null \
    && apt-get update \
    && apt-get -y install podman slirp4netns \
    && echo "Install Snap" \
    && apt-get -y install snapd \
    && echo "Install Credential and secret required packages (Jetbrains Tool required)" \
    && apt-get -y install libsecret-1-0 gnome-keyring \
    && echo "Install sudo" \
    && apt-get -y install sudo \
    && echo "Install Micromamba -- a replacement of miniconda" \
    && mkdir -p /opt/micromamba \
    && apt-get -y install bzip2 \
    && curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj -C /opt/micromamba/ bin/micromamba \
    && echo "Install neovim -- a replacement of vi/vim" \
    && deb=$(curl -w "%{filename_effective}" -LO https://github.com/neovim/neovim/releases/download/v0.8.3/nvim-linux64.deb) \
    && dpkg -i $deb && rm $deb && unset deb \
    && ln -s /usr/bin/nvim /usr/local/bin/vim \
    && apt-get -y install ripgrep \
    && echo "Clean up installation" \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Enterprise
COPY ./ca-certificates/* /usr/local/share/ca-certificates/
RUN update-ca-certificates -f