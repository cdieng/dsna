FROM docker.io/library/centos:8.3.2011
RUN dnf update -y
RUN dnf upgrade -y
COPY epel-el7.repo /etc/yum.repos.d/epel-el7.repo
RUN dnf --enablerepo=epel-el7 install wiredtiger wiredtiger-devel -y
RUN dnf install wget vim cyrus-sasl-devel libtool-ltdl-devel openssl-devel libdb-devel make libtool autoconf  tar gcc perl perl-devel wget vim rsyslog -y
RUN ls /etc/openldap
RUN useradd -r -M -d /var/lib/openldap -u 55 -s /usr/sbin/nologin ldap
RUN wget https://www.openldap.org/software/download/OpenLDAP/openldap-release/openldap-2.5.7.tgz
RUN tar -zxvf openldap-2.5.7.tgz -C /etc/openldap
RUN ls /etc/openldap
RUN cd /etc/openldap/openldap-2.5.7 && ls && ./configure --prefix=/usr --sysconfdir=/etc --disable-static --enable-debug --with-tls=openssl --with-cyrus-sasl --enable-dynamic --enable-crypt --enable-spasswd --enable-slapd --enable-modules --enable-rlookups --enable-backends=mod --disable-ndb --disable-sql --disable-shell --disable-bdb --disable-hdb --enable-overlays=mod && make depend && make &&  make install

RUN ls /etc/openldap
RUN mkdir /var/lib/openldap /etc/openldap/slapd.d
RUN chown -R ldap:ldap /var/lib/openldap
RUN chown root:ldap /etc/openldap/slapd.conf
RUN chmod 640 /etc/openldap/slapd.conf
RUN dnf install -y sudo
RUN sudo -V |  grep -i "ldap"
RUN rpm -ql sudo |  grep -i schema.openldap
RUN cp /usr/share/doc/sudo/schema.OpenLDAP  /etc/openldap/schema/sudo.schema
#RUN mv /etc/openldap/slapd.ldif /etc/openldap/slapd.ldif.bak

COPY sudo.ldif /etc/openldap/schema/sudo.ldif
RUN mkdir /etc/systemd/system/slapd.service.d/
COPY slapd.service /etc/systemd/system/slapd.service

#COPY slapd.ldif  /etc/openldap/slapd.ldif

#RUN slapadd -n 0 -F /etc/openldap/slapd.d -l /etc/openldap/slapd.ldif -u
#RUN slapadd -n 0 -F /etc/openldap/slapd.d -l /etc/openldap/slapd.ldif
#RUN ls /etc/openldap/slapd.d
#RUN chown -R ldap:ldap /etc/openldap/slapd.d
#RUN ls /etc/openldap/slapd.d

RUN ln -s /etc/systemd/system/slapd.service  /etc/systemd/system/multi-user.target.wants/slapd.service

#RUN su root -c 'systemctl daemon-reload'
#RUN su root -c 'systemctl enable --now slapd'
#RUN su root -c 'systemctl status slapd'

#COPY enable-ldap-log.ldif /etc/openldap/
#RUN ldapmodify -Y external -H ldapi:/// -f /etc/openldap/enable-ldap-log.ldif
#RUN ldapsearch -Y EXTERNAL -H ldapi:/// -b cn=config "(objectClass=olcGlobal)" olcLogLevel -LLL -Q

RUN echo "local4.* /var/log/slapd.log" >> /etc/rsyslog.conf
#RUN su root -c 'systemctl restart rsyslog'

#COPY rootdn.ldif /etc/openldap/
#RUN ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/rootdn.ldif

#COPY add-tls.ldif /etc/openldap
#RUN su root -c 'ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/add-tls.ldif

#RUN su root -c 'slapcat -b "cn=config" | grep olcTLS'

#RUN su root -c 'echo "TLS_CACERT     /etc/pki/tls/ldapserver.crt" >> /etc/openldap/ldap.conf'


EXPOSE 389 636


CMD [ "/sbin/init" ]

