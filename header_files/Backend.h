#include<QObject>
#include<QString>
#include<QTimer>
#include<QDateTime>
#include<QVariantList>
#include <DataSql.h>

//   QString q = R"(INSERT INTO users( user_name
//                                     , user_password
//                                     , user_email)
//                                 VALUES(
//                                     :name,
//                                     :email
//                                     :password)
                                        
//                                     )";



class BACKEND : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool car_locked READ car_locked WRITE set_car_locked NOTIFY Car_is_locked)
    Q_PROPERTY(int temprature READ temprature WRITE set_temprature NOTIFY temp_checked)
    Q_PROPERTY(QString user_name READ user_name WRITE set_user_name NOTIFY name_set)
    Q_PROPERTY(QString user_email READ user_email NOTIFY email_set)
    Q_PROPERTY(QVariantList users READ users NOTIFY users_changed)
    Q_PROPERTY(QString current_time READ current_time NOTIFY time_changed)

private:
    bool m_car_locked = true;
    int m_temprature = 32;
    QString m_username = "Awais Ashraf";
    QString m_useremail;
    QVariantList m_users;
    QTimer *m_time;
    QString time_now;
    DATASQL &db = DATASQL::Create_Database_Instance();
    
public:
    explicit BACKEND(QObject *parent = nullptr);
    ~BACKEND();

    Q_INVOKABLE void Add_User(QString name , QString mail , QString password);
    Q_INVOKABLE void Load_Users();
    Q_INVOKABLE void Delet_Users();

    bool car_locked();
    void set_car_locked(bool lock);
    int temprature();
    void set_temprature(int new_temp);
    void set_user_name(QString name);
    void Time_setter();
    QString user_name();
    QString user_email();
    QVariantList users();
    QString current_time();

signals:
    void Car_is_locked();
    void temp_checked();
    void name_set();
    void email_set();
    void users_changed();
    void time_changed();
};