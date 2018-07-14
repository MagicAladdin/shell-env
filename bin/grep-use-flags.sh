#!/bin/bash

cd /etc/portage/package.use

for f in $(ls); do
	cat $f | grep $1
done
