echo "Start installing packages..."
for s in $(find /dev-install-files -name user-install.sh -type f -printf '%h\0%d\0%p\n' | sort -t '\0' -n | awk -F'\0' '{print $3}'); do "$s"; done