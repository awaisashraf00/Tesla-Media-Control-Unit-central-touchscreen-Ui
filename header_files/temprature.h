#include<QObject>
#include<QString>
#include<QTimer>
#include<QDateTime>

class TEMPRATURE_CONTROLS : public QObject
{
    Q_OBJECT
    Q_PROPERTY(float current_temp READ current_temp WRITE set_current_temp NOTIFY temp_changed)

private:
    float m_target_temprature = 0.0;
    float current_temp();
public:
    Q_INVOKABLE void incerment_temprature();
    Q_INVOKABLE void decerment_temprature();
    TEMPRATURE_CONTROLS(QObject *parent = nullptr);
    ~TEMPRATURE_CONTROLS();
    void set_current_temp( float new_temp);
signals:
    void temp_changed();

};