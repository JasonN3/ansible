#!/bin/bash

slide=$1
sat_users=$2

steps=$(seq -s, 0 ${slide})

for sat_user in $(echo $sat_users | tr ',' ' ')
do
    #ansible-playbook --tags "demo_all,${steps}" lab.yaml --extra-vars "organization=Demo_${sat_user}"
    ansible-playbook lab.yaml
done