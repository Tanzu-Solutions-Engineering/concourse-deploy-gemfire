#!/bin/bash -e
set -xe

ls -lha
cd java-keystore

keytool -genkeypair \
-dname "cn=Your Name, ou=GemFire, o=GemStone, c=US" \
-storetype PKCS12 \
-keyalg RSA \
-keysize 2048 \
-alias valid-client \
-keystore valid-client.keystore \
-storepass $KEYSTORE_PASS \
-validity 180

keytool -exportcert \
-storetype PKCS12 \
-keyalg RSA \
-keysize 2048 \
-alias valid-client \
-keystore valid-client.keystore \
-storepass $KEYSTORE_PASS \
-rfc \
-file valid-client.cer

keytool -import \
-file valid-client.cer \
-alias valid-client \
-keystore truststore \
-storepass $KEYSTORE_PASS \
-noprompt

#Copy versioned files so S3 can hanlde them
cp valid-client.cer valid-client-1.cer
cp valid-client.keystore valid-client-1.keystore
