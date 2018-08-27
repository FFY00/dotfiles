#!/bin/bash

gpg --keyserver hkp://pgp.mit.edu --send-key $@ &
gpg --keyserver hkp://keys.gnupg.net --send-key $@ &
gpg --keyserver mailto:pgp-public-keys@keys.nl.pgp.net --send-key $@ &
gpg --keyserver ldap://keyserver.pgp.com --send-key $@ &
gpg --keyserver hkp://keyserver.ubuntu.com --send-key $@ &
gpg --keyserver hkp://pgp.key-server.io --send-key $@ &
gpg --keyserver hpk://pool.sks-keyservers.net --send-key $@ &
gpg --keyserver hpk://sks-keyservers.net --send-key $@ &
gpg --keyserver hkp://gozer.rediris.es --send-key $@ &
gpg --keyserver hkp://kerckhoffs.surfnet.nl --send-key $@ &
#gpg --keyserver hkp://keys.niif.hu --send-key $@ &
gpg --keyserver hkp://keyserver.oeg.com.au --send-key $@ &
gpg --keyserver hkp://keyserver.stack.nl --send-key $@ &
gpg --keyserver hkp://pgp.zdv.uni-mainz.de --send-key $@ &
gpg --keyserver hkp://keyserver.cais.rnp.br --send-key $@ &
