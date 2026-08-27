#include "temprature.h"

TEMPRATURE_CONTROLS::TEMPRATURE_CONTROLS(QObject *parent): m_target_temprature(33)
{
}

TEMPRATURE_CONTROLS::~TEMPRATURE_CONTROLS()
{
}

float TEMPRATURE_CONTROLS::current_temp()
{
    return m_target_temprature;
}

void TEMPRATURE_CONTROLS::set_current_temp(float new_temp)
{
    if(m_target_temprature == new_temp){
        return;
    }else{
        m_target_temprature;
    }
}

void TEMPRATURE_CONTROLS::incerment_temprature()
{
    m_target_temprature++;
    emit temp_changed();
}

void TEMPRATURE_CONTROLS::decerment_temprature()
{
    m_target_temprature--;
    emit temp_changed();
}
