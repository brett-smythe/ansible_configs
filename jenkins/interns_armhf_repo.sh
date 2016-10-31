#!/bin/bash
old_debfile=$(aptly repo search internal-jessie 'interns-twitter {armhf}')
 if [ "$old_debfile" != "" ]; then
    (aptly repo remove internal-jessie $old_debfile || : )
fi
debfile=$(find /var/lib/jenkins/armhf_build/interns/ -maxdepth 1 -name *\.deb*)
(aptly repo add internal-jessie $debfile || : )
(aptly snapshot create $debfile-stable from repo internal-jessie || : )
(aptly publish drop jessie,wheezy || : )
aptly publish snapshot -architectures=amd64,armhf,i386 $debfile-stable
rm $debfile
