#/bin/bash


podman run -it --rm --name  openldap \
--hostname hyp03.lfpw.dsna.fr \
--env LDAP_ORGANISATION="Dsna" \
--env LDAP_DOMAIN="lfpw.dsna.fr" \
--env LDAP_ADMIN_PASSWORD="redhat" \
--env LDAP_CONFIG_PASSWORD="redhat" \
--env LDAP_READONLY_USER_PASSWORD="redhat" \
-p 1389:389 \
-p 1636:636 \
dsna/openldap:0.1.2 --loglevel=debug
