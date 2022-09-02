#!/bin/sh

# (1) set up all the mysqldump variables
FILE=files/backup.sql.`date +"%Y%m%d"`

DATABASE=check_printer_admin
USER=root
PASS=7maAGNB5BQkNE9ZA1OeUba6eysNgqxbY

# (2) in case you run this more than once a day, remove the previous version of the file
unalias rm     2> /dev/null
rm ${FILE}     2> /dev/null
rm ${FILE}.gz  2> /dev/null

# (3) do the mysql database backup (dump)

# use this command for a database server on a separate host:
#mysqldump --opt --protocol=TCP --user=${USER} --password=${PASS} --host=${DBSERVER} ${DATABASE} > ${FILE}

# use this command for a database server on localhost. add other options if need be.
docker exec check-printer-db mysqldump -u${USER} -p${PASS} ${DATABASE} > ${FILE}

# (4) gzip the mysql database dump file
gzip $FILE

# (5) remove files older 7 days
find files/ -type f -mtime +7 -name '*.gz' -execdir rm -- '{}' \;

