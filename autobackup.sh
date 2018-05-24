#!/bin/bash

backup_date=$(date +"%Y%m%d")
old_backup_date=$(date -d -3day +"%Y%m%d")
# webdav用户名
username=""
# webdav密码
password=""
# webdav服务器地址
server_address=""

echo "deleting old backups" &&
rm -rf /home/backup/* &&
echo "backuping" &&
# 下面是lnmp一键包的备份脚本的路径
/home/kzw/lnmp*/tools/backup.sh &&
echo "packaging" &&6
tar -zcf /home/backup-${backup_date}.tar.gz -C /home backup &&
echo "uploading" &&
curl -u "${username}:${password}" -T "/home/backup-${backup_date}.tar.gz" "${server_address}" &&
rm -f /home/backup-${backup_date}.tar.gz &&
echo "deleting old backups on the remote server"
curl -u "${username}:${password}" -X DELETE "${server_address}backup-${old_backup_date}.tar.gz" 
