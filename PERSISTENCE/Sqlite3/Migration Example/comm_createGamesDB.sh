#!bin/bash

DBNAME=$1

#######Methods
createDatabase()
{


#updating vars
DBNAME+=".db"
DBTABLE=videoGames

##exec command
sqlite3 $DBNAME << EOF

DROP TABLE IF EXISTS $DBTABLE;

CREATE TABLE $DBTABLE(
	"name" text,
	"type" text
);

INSERT INTO $DBTABLE ("name","type") VALUES ("final fantansy", "rpg");
INSERT INTO $DBTABLE ("name","type") VALUES ("elder scrolls", "rpg");

.dump

EOF
}


###MAIN
if [ -z $DBNAME ]
then 
	echo "Missing Database name\n usage: $0 Databasename"
else
	createDatabase	
fi


