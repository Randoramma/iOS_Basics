#!bin/bash

DB_NAME=$1
DB_KEY=$2
DB_CIPHER=$3

####Methods
decryptDatabase()
{

#updating vars
CIPHER='aes-256-'
CIPHER+=$DB_CIPHER

echo "\nDecrypting database '$DB_NAME' with Key '$DB_KEY' and cipher: '$CIPHER'\n";

#exec command
sqlcipher $DB_NAME << EOF

PRAGMA key = '$DB_KEY';

PRAGMA cipher = '$CIPHER';

.tables

.dump

EOF

}

USAGE='usage: $0 databaseName databaseKey databaseCipher(cbc,gcm,etc)'

#### Main
if [ -z $DB_NAME ]
then
        echo "$USAGE"
else
        if [ -z $DB_KEY ]
        then
                echo "$USAGE"
        else
                if [ -z $DB_CIPHER ]
        	then
                	echo "$USAGE"
        	else
                	decryptDatabase
        	fi
        fi
fi

