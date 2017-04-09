#!bin/bash

DB_NAME=$1
DB_KEY=$2
DB_NEW_NAME=$3
DB_NEW_KEY=$4
DB_ENCRYPT_MODE=$5

####Methods
changeDatabaseSettings()
{

#UPDATING VARS
DB_NEW_FILENAME="$DB_NEW_NAME"
DB_NEW_FILENAME+=".db"
DB_ENCRYPT="aes-256-"
DB_ENCRYPT+="$DB_ENCRYPT_MODE"
DB_ENCRYPT_CIPHER="$DB_NEW_NAME"
DB_ENCRYPT_CIPHER+=".cipher"

echo "\nCreating new database '$DB_NEW_NAME' from '$DB_NAME (existing key '$DB_KEY') ', with updated Key ='$DB_NEW_KEY' and cipher mode'$DB_ENCRYPT_MODE'\n";

#exec command
sqlcipher $DB_NAME << EOF

PRAGMA key = '$DB_KEY';

ATTACH DATABASE '$DB_NEW_FILENAME' AS $DB_NEW_NAME KEY '$DB_NEW_KEY';

PRAGMA $DB_ENCRYPT_CIPHER = '$DB_ENCRYPT';

SELECT sqlcipher_export('$DB_NEW_NAME');

DETACH DATABASE $DB_NEW_NAME;   


EOF

}


USAGE="Usage: $0 db.Name db.Key db.NewName(without .db) db.NewKey db.EncryptionMode(cbc, gcm, etc)"

#### Main
if [ -z $DB_NAME ]
then
	echo $USAGE;
else
        if [ -z $DB_KEY ]
        then
		echo $USAGE;
        else
               	if [ -z $DB_NEW_NAME ]
        	then
			echo $USAGE;
       		else
               		if [ -z $DB_NEW_KEY ]
                	then
                        	echo $USAGE;
                	else
                        	if [ -z $DB_ENCRYPT_MODE ]
                		then
                        		echo $USAGE;
                		else
                			changeDatabaseSettings
				fi
                	fi
       		fi
        fi
fi

