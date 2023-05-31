#!/bin/bash

cat << EOF
===================================
- Zulu JDK
    - Create ~/.keystore
    - Import certificates to keystore
===================================
EOF

for s in $(find /usr/local/share/ca-certificates/ -type f); 
do 
    bash -c "keytool -importcert -alias $(basename $s) -file $s -storepass changeit -noprompt";
done
