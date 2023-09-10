#!/bin/bash

cat << EOF
===================================
- Generate default truststore (need to install after jdk installed)
    - Create ~/jssecacerts (default truststore location)
    - Import certificates to ~/jssecacerts
===================================
EOF

for s in $(find /usr/local/share/ca-certificates/ -type f);
do 
    bash -c "keytool -importcert -alias $(basename $s) -file $s -storepass changeit -noprompt -keystore ~/jssecacerts";
done
