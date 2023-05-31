FROM ubuntu:latest

# Enterprise certificate
COPY ./ca-certificates/. /usr/local/share/ca-certificates/

RUN update-ca-certificates -f \
    && apt-get update \
    && echo "Install required/common tool to manage package installation" \
    && apt-get -y install gpg lsb-release sudo wget curl crudini \
    && mkdir -p /dev-install-files/

COPY --chmod=777 packages shells first-launch /dev-install-files/

RUN echo "Start installing packages/shells..." \
    && for s in $(find /dev-install-files -name root-install.sh -type f -printf '%h\0%d\0%p\n' | sort -t '\0' -n | awk -F'\0' '{print $3}'); do "$s"; done \
    && echo "Merge all wsl.conf" \
    && touch /etc/wsl.conf \
    && for s in $(find /dev-install-files -type f -name wsl.conf); do bash -c "crudini --merge --output=/etc/wsl.conf /etc/wsl.conf < $s"; done \
    && echo "Merge all .wslconfig" \
    && mkdir -p /opt/wsl \
    && touch /opt/wsl/.wslconfig \
    && for s in $(find /dev-install-files -type f -name .wslconfig); do bash -c "crudini --merge --output=/opt/wsl/.wslconfig /opt/wsl/.wslconfig < $s"; done \
    && echo "Merge all .wslgconfig" \
    && touch /opt/wsl/.wslgconfig \
    && for s in $(find /dev-install-files -type f -name .wslgconfig); do bash -c "crudini --merge --output=/opt/wsl/.wslgconfig /opt/wsl/.wslgconfig < $s"; done \
    && echo "Clean up installation" \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/*

