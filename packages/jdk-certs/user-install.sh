#!/bin/bash

cat << EOF
===================================
- Import certificates
    - Create ~/.keystore
    - Import certificates to keystore
===================================
EOF

for s in $(find /usr/local/share/ca-certificates/ -type f); 
do 
    bash -c "keytool -importcert -alias $(basename $s) -file $s -storepass changeit -noprompt";
done
