#include <Backend.h>

BACKEND::BACKEND(QObject *parent)
    : QObject(parent)
    {
        m_time = new QTimer(this);
        m_time->setInterval(500);
        connect(m_time,&QTimer::timeout,this,&BACKEND::Time_setter);
        Time_setter();
    }
    
BACKEND::~BACKEND(){
    delete m_time;
}

void BACKEND::Add_User()
{
    QString q = R"(INSERT INTO users( user_name
                                    , user_password
                                    , user_email)
                                VALUES(
                                    :name,
                                    :email
                                    :password)
                                        
                                    )";
    db.query.bindValue(":name", "John Doe");
    db.query.bindValue(":email", "john@example.com");
    db.query.bindValue(":password", "Anything");
    
    db.query.prepare(q);
    db.query.exec();
    
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
