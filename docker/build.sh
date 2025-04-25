#!/bin/bash


script_dir=$(cd "$(dirname "$0")"; pwd)



#rm -rf $script_dir/bao/nodami-server/server
#rm -rf $script_dir/bao/nodami-server/public
#rm -rf $script_dir/bao/nodami-server/config/agentInstall
#rm -rf $script_dir/bao/nodami-server/config/casbin_conf
#rm -rf $script_dir/bao/nodami-server/template
#rm -rf $script_dir/bao/nodami-server/server.sql



cd $script_dir/../server
GOOS=linux GOARCH=amd64 go build -o $script_dir/bao/nodami-server/server ./main.go
chmod +x $script_dir/bao/nodami-server/server

#
#cd $script_dir/../server-web
#
#
#npm i
#npm run build:prod
#
#
#cp -r $script_dir/../server/public              $script_dir/bao/nodami-server
#cp -r $script_dir/../server/config/agentInstall $script_dir/bao/nodami-server/config
#cp -r $script_dir/../server/config/casbin_conf  $script_dir/bao/nodami-server/config
#cp -r $script_dir/../server/template            $script_dir/bao/nodami-server
#cp -r $script_dir/../Nodami.sql                 $script_dir/bao/nodami-server


