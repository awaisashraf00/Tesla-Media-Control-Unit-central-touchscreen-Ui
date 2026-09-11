#include <QtSql/QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlRecord>

class DATASQL{
    private:
        
    public:
        DATASQL();
        ~DATASQL();
        static DATASQL &Create_Database_Instance();
        QSqlDatabase mydb;
        QSqlDatabase Create_Database();
        QSqlQuery query;

};