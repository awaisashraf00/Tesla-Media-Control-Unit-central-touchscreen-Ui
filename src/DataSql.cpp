#include "DataSql.h"

DATASQL::DATASQL(){

    mydb = QSqlDatabase::addDatabase("QSQLITE");
    mydb.setDatabaseName("/Users/sherazrajput/Cpp-Projects/TeslaMCU/DataBase.db");

    if(!mydb.open()){
        qDebug()<<"Error While Opening";
    }else{
        qDebug()<<"Opened successfully";
    }

    query = QSqlQuery(mydb);
    
    if (!query.exec(R"(
        CREATE TABLE IF NOT EXISTS users (
            user_id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_name TEXT NOT NULL,
            user_password TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE
        )
    )")) {
        qDebug() << "Error while creating users table:" << query.lastError().text();
    }

}

DATASQL::~DATASQL(){

}

DATASQL &DATASQL::Create_Database_Instance()
{
    static DATASQL instance;
    return instance;
}

QSqlDatabase DATASQL::Create_Database()
{
    return mydb;
}
