import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CreateTables{

    // This function will create the database.
    static createTableStatement(String tableName) async {
        switch(tableName){
            case 'Posts':
                // Open the database.
                print(tableName+" From CreateTables");
                Future<Database> db = openDatabase(
                    join(await getDatabasesPath(), 'project_database.db'),
                    version: 1
                );
                Database database = await db;
                database.rawQuery('CREATE TABLE IF NOT EXISTS posts (id INTEGER PRIMARY KEY, userId INTEGER, title VARCHAR(50), body VARCHAR(100))');
                database.close();
                break;
            case 'Comments':
                print(tableName+" From CreateTables");
                // Open the database.
                Future<Database> db = openDatabase(
                    join(await getDatabasesPath(), 'project_database.db'),
                    version: 1
                );
                Database database = await db;
                database.rawQuery('CREATE TABLE IF NOT EXISTS comments (id INTEGER PRIMARY KEY, postId INTEGER, name VARCHAR(50), email VARCHAR(50), body VARCHAR(100))');
                database.close();
                break;
            default:
                return "No table created with given Name";
        }

    }


}



