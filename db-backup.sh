#!/usr/bin/env bash

#-----------------------------------------#
#------ by kidali.a.kevin@gmail.com ------#
#-----------------------------------------#

#-- Database connection settings ---#
#-----------------------------------#
HOST_NAME="localhost"
USER_NAME=""
PASSWORD=""
DB_NAME=""
PORT=3306

#---------- CONFIGS -----------#
CURRENT_DATE=`date +"%d-%m-%Y"`
DB_FOLDER=""
GIT_RP_NAME=""
GIT_USERNAME=""
GIT_PASSWORD=""

#---------- CREATE BACKUP FOLDER -----#
mkdir -p ${DB_FOLDER}/${CURRENT_DATE}

#------ RUN COMMANDD --------#
mysqldump -h ${HOST_NAME} -P ${PORT} -u ${USER_NAME} -p${PASSWORD} ${DB_NAME} > ${DB_FOLDER}/${CURRENT_DATE}/${DB_NAME}_${CURRENT_DATE}.sql

#---------- CONFIRM THE SUCCESS OF THE PROCESS -----------#
if [ $? -ne "0" ]; then
         rm -r ${DB_FOLDER}/${CURRENT_DATE}
         echo ${CURRENT_DATE} "failed" >> ${DB_FOLDER}/logs-backup.txt
    else
         echo ${CURRENT_DATE} "success" >> ${DB_FOLDER}/logs-backup.txt
fi

#------------ GIT DATABASE BACK UP --------------#
if [ -d "${DB_FOLDER}/.git" ]; then
    echo "${CURRENT_DATE}-backup" >> $DB_FOLDER}/README.md
    cd ${DB_FOLDER} ; git add .
    cd ${DB_FOLDER} ; git add-commit -m "${CURRENT_DATE}-backup"
    cd ${DB_FOLDER} ; git push
else
    echo "# Database back up" >> ${DB_FOLDER}/README.md
    cd ${DB_FOLDER} ; git init
    cd ${DB_FOLDER} ; git remote add origin https://github.com/${GIT_USERNAME}/${GIT_RP_NAME}.git
    cd ${DB_FOLDER} ; git remote set-url origin https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/${GIT_USERNAME}/${GIT_RP_NAME}.git
    cd ${DB_FOLDER} ; git add-commit -m "first commit"
    cd ${DB_FOLDER} ; git push --set-upstream origin master
fi