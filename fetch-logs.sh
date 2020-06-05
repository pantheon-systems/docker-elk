#!/bin/bash

for app_server in `dig +short -4 appserver.$ENV.$SITE_UUID.drush.in`;
do
  rsync -rlvz --size-only --ipv4 --progress -e 'ssh -p 2222' $ENV.$SITE_UUID@$app_server:logs/* logstash/container-logs/app_server_$app_server
done

# Include MySQL logs
for db_server in `dig +short -4 dbserver.$ENV.$SITE_UUID.drush.in`;
do
  rsync -rlvz --size-only --ipv4 --progress -e 'ssh -p 2222' $ENV.$SITE_UUID@$db_server:logs/* logstash/container-logs/db_server_$db_server
done
