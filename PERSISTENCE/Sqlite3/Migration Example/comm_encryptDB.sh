#!bin/bash

DB_NAME=$1
ENCRYPTED_NAME=$2
ENCRYPTION_KEY=$3

####Methods
encryptedDatabase()
{

#updating vars
ENCRYPTED_FILENAME="$ENCRYPTED_NAME"
ENCRYPTED_FILENAME+=".db"

echo "\nCreating Encrypted Database '$ENCRYPTED_FILENAME' with key '$ENCRYPTION_KEY'\n";


sqlcipher $DB_NAME << EOF

ATTACH DATABASE '$ENCRYPTED_FILENAME' AS $ENCRYPTED_NAME KEY '$ENCRYPTION_KEY';

SELECT sqlcipher_export('$ENCRYPTED_NAME');

DETACH DATABASE $ENCRYPTED_NAME;

EOF

}

USAGE="usage: $0 databaseName newDatabaseName(without .db) newDatabaseKey"

#### Main
if [ -z $DB_NAME ]
then
        echo "$USAGE"
else
        if [ -z $ENCRYPTED_NAME ]
        then
                echo "$USAGE"
        else
                if [ -z $ENCRYPTION_KEY ]
        	then
               		echo "$USAGE"
        	else
                	encryptedDatabase
        	fi
        fi
fi

