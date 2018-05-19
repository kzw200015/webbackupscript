#!/bin/bash

backup_date=$(date +"%Y%m%d")
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
echo "packaging" &&
tar -zcf /home/backup-${backup_date}.tar.gz -C /home backup &&
echo "uploading" &&
curl -u "${username}:${password}" -T "/home/backup-${backup_date}.tar.gz" "${server_address}" &&
rm -f /home/backup-${backup_date}.tar.gz