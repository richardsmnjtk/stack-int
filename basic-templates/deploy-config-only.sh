#!/bin/bash

source ~/stackrc
t1=$(date +'%s')
start_deploy=$(date)

openstack overcloud deploy \
--answers-file ~/basic-templates/overcloud-answers.yaml \
-r ~/basic-templates/roles_data.yaml \
--config-download-only

t2=$(date +'%s')
finish_deploy=$(date)
t_delta=$(bc <<< "($t2 - $t1)")
t_delta_mins=$(bc <<< "($t_delta / 60)")
t_delta_hour=$(bc <<< "($t_delta_mins / 60)")
t_delta_min=$(bc <<< "$t_delta_mins - ($t_delta_hour * 60)")
t_delta_sec=$(bc <<< "$t_delta - ($t_delta_mins * 60)")

echo "$(date +'%F %T.%3N') | Started deploy at: ${start_deploy}" 
echo "$(date +'%F %T.%3N') | Finised deploy at: ${finish_deploy}"
echo "$(date +'%F %T.%3N') | Total duration: $t_delta_hour hour(s), $t_delta_min min(s), $t_delta_sec sec(s)"
