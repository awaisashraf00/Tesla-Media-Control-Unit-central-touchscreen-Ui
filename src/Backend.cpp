#include <Backend.h>

BACKEND::BACKEND(QObject *parent)
    : QObject(parent)
    {
        m_time = new QTimer(this);
        m_time->setInterval(500);
        connect(m_time,&QTimer::timeout,this,&BACKEND::Time_setter);
        Time_setter();
        Load_Users();
    }
    
BACKEND::~BACKEND(){
    delete m_time;
}

void BACKEND::Add_User(QString name , QString mail , QString password)
{

    QString q = R"(INSERT INTO users( user_name
                                    , user_password
                                    , email)
                                VALUES(
                                    :name,
                                    :password,
                                    :email
                                    )
                                        
                                    )";

    db.query.prepare(q);
    db.query.bindValue(":name", name);
    db.query.bindValue(":email", mail);
    db.query.bindValue(":password", password);

    if (db.query.exec()) {
        m_username = name;
        m_useremail = mail;
        emit name_set();
        emit email_set();
        Load_Users();
    }
}

void BACKEND::Load_Users()
{
    QVariantList loaded_users;
    QSqlQuery users_query(db.Create_Database());

    if (users_query.exec("SELECT user_id, user_name, email FROM users ORDER BY user_id")) {
        while (users_query.next()) {
            QVariantMap user;
            user["id"] = users_query.value("user_id");
            user["name"] = users_query.value("user_name");
            user["email"] = users_query.value("email");
            loaded_users.append(user);
        }
    }

    m_users = loaded_users;
    emit users_changed();
}

void BACKEND::Delet_Users()
{
    QSqlQuery users_query(db.Create_Database());

    if (users_query.exec("DELETE FROM table_name WHERE id = 5;")) {
        qDebug()<<"query success deleted user";
    }

    emit users_changed();
}

bool BACKEND::car_locked()
{
    return m_car_locked;
}

void BACKEND::set_car_locked(bool lock)
{
    if(m_car_locked == lock){
        return;
    }else{
        m_car_locked = !m_car_locked;
        emit Car_is_locked();
    }
}

int BACKEND::temprature()
{
    return m_temprature;
}

void BACKEND::set_temprature( int new_temp)
{
    if(m_temprature == new_temp){
        return;
    }else{
        m_temprature = new_temp;
        emit temp_checked();
    }

}

QString BACKEND::user_name()
{
    return (m_username);
}

QString BACKEND::user_email()
{
    return m_useremail;
}

QVariantList BACKEND::users()
{
    return m_users;
}

void BACKEND::set_user_name(QString name)
{
    if(m_username == name){
        return;
    }else{
        m_username = name;
        emit name_set();
    }
}

void BACKEND::Time_setter()
{
    QDateTime date;
    time_now = date.currentDateTime().toString("hh:mm AP");
    m_time->start();
    emit time_changed();
}

QString BACKEND::current_time()
{
    return time_now;
}
