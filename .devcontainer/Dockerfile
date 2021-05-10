# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.159.0/containers/rust/.devcontainer/base.Dockerfile
# FROM mcr.microsoft.com/vscode/devcontainers/rust:0-1

FROM rust:1

# [Option] Install zsh
ARG INSTALL_ZSH="true"
# [Option] Upgrade OS packages to their latest versions
ARG UPGRADE_PACKAGES="false"

# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
COPY library-scripts/*.sh /tmp/library-scripts/
# RUN mv /tmp/library-scripts/usb-reloader.sh /usr/local/bin/docker_tty.sh
# RUN chmod +x /usr/local/bin/docker_tty.sh

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    # Remove imagemagick due to https://security-tracker.debian.org/tracker/CVE-2019-10131
    && apt-get purge -y imagemagick imagemagick-6-common \
    # Install common packages, non-root user, updated lldb, dependencies
    && bash /tmp/library-scripts/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" \
    && bash /tmp/library-scripts/rust-debian.sh "${CARGO_HOME}" "${RUSTUP_HOME}" "${USERNAME}" "true" "true" \
    # && bash /tmp/library-scripts/addRules.sh \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts

# [Optional] Uncomment this section to install additional packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    udev \
    usbutils \
    stlink-tools \
    gdb-multiarch \
    openocd \
    qemu-system-arm
RUN cargo install cargo-generate && rustup target add thumbv7m-none-eabi
RUN git clone --depth 1 https://github.com/junegunn/fzf.git /home/vscode/.fzf