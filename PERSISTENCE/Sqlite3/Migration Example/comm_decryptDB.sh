#!bin/bash

DB_NAME=$1
DB_KEY=$2

####Methods
decryptDatabase()
{
echo "\nDecrypting database '$DB_NAME' with key '$DB_KEY'\n";

sqlcipher $DB_NAME << EOF

PRAGMA key = '$DB_KEY';

.tables

EOF

}

USAGE='usage: $0 databaseName databaseKey';

#### Main
if [ -z $DB_NAME ]
then
        echo "$USAGE"
else
        if [ -z $DB_KEY ]
        then
                echo "$USAGE"
        else
                decryptDatabase
        fi
fi

