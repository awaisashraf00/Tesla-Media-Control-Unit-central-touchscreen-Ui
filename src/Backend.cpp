#include <Backend.h>

BACKEND::BACKEND(QObject *parent)
{
}

bool BACKEND::car_locked()
{
    return m_car_locked;
}

void BACKEND::set_car_locked(bool lock)
{
    if(m_car_locked && lock){
        return;
    }else{
        m_car_locked = !m_car_locked;
    }
}
