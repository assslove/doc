#!/bin/bash
# clear log everyday and backup to one dir
# usage : ./logManager.sh 3 /home/bin.hou/log/backup  /home/bin.hou/log 
# backup days 
if [ $# -lt 3 ]
then
	echo "usage error"
	echo "usage : ./logManager.sh 3 /home/bin.hou/log/backup  /home/bin.hou/log"
	exit 1
fi

BACKDAY=`expr $1 + 1`
# backup dir
BACKUP_DIR=$2
#clear dirs
CLEAR_DIR=$3

if [ ! -d $CLEAR_DIR ]
then
	echo "$CLEAR_DIR not exist"
	exit 1
fi

if [ $1 -lt  0 ]
then
	$BACKDAY=3
fi

if [ ! -d $BACKUP_DIR ]
then
	mkdir $BACKUP_DIR
fi

# clear day before $BACKDAY
deldir=$BACKUP_DIR/`date +%Y%m%d --date="-${BACKDAY} day"`
if [ -d $deldir ]
then
	rm -rf $deldir
fi

# mv clear_dir to backup_dir
backup=$BACKUP_DIR/`date +%Y%m%d --date="-1 day"`

if [ ! -d $backup ]
then
	mkdir $backup
fi

src=$CLEAR_DIR/*`date +%y-%m-%d --date="-1 day"`*
mv $src $backup
echo "success backup $src log to $backup"
