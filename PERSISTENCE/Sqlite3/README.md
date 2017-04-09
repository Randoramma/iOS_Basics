
###Operations

* Create a Database **
sqlite3 sampledb.sql

** Create a new table ** ***(Inside SQLite command line)***
CREATE TABLE peopleInfo(peopleInfoID integer primary key, firstname text, lastname text, age integer);

** Quit SQLite environment **  ***(Inside SQLite command line)***
.quit


**Example:**
	//1.start console
	sqlite3 games.sql

	//2. create table
	create table video_games(name text, type text);

	//3.insert data to table
	insert into video_games values('fallout', 'rpg');
	insert into video_games values('final fantansy', 'rpg');

	//4. select data from table - to verify it stored
	select * from video_games where type='rpg';


####Meta Commands
.show	Displays current settings for various parameters
.databases	Provides database names and files
.quit	Quit sqlite3 program
.tables	Show current tables
.schema	Display schema of table
.header	Display or hide the output table header
.mode	Select mode for the output table
.dump	Dump database in SQL text format


###NOTES

When you add the .sql file to the xcode project, make sure to:
- Copy Items if Needed
- Create Group For reference
- Selected App Target




###Functions


**sqlite3_open:**
This function is used to create and open a database file. It accepts two parameters, where the first one is the database file name, and the second a handler to the database. If the file does not exist, then it creates it first and then it opens it, otherwise it just opens it.

**sqlite3_prepare_v2:**
The purpose of this function is to get a SQL statement (a query) in string format, and convert it to an executable format recognizable by SQLite 3.

**sqlite3_step:**
This function actually executes a SQL statement (query) prepared with the previous function. It can be called just once for executable queries (insert, update, delete), or multiple times when retrieving data. It’s important to have in mind that it can’t be called prior to the sqlite3_preprare_v2 function.

**sqlite3_column_count:**
This method’s name it makes it easy to understand what is about. It returns the total number of columns (fields) a contained in a table.

**sqlite3_column_text:**
This method returns the contents of a column in text format, actually a C string (char *) value. It accepts two parameters: The first one is the query converted (compiled) to a SQLite statement, and the second one is the index of the column.

**sqlite3_column_name:**
It returns the name of a column, and its parameters are the same to the previous function’s.

**sqlite3_changes:**
It actually returns the number of the affected rows, after the execution of a query.

**sqlite3_last_insert_rowid:**
It returns the last inserted row’s ID.

**sqlite3_errmsg:**
It returns the description of a SQLite error.

**sqlite3_finalize:**
It deletes a prepared statement from memory.

**sqlite3_close:**
It closes an open database connection. It should be called after having finished any data exchange with the database, as it releases any reserved system resources.


