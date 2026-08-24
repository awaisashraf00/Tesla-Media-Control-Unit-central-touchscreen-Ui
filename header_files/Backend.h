#include<QObject>

class BACKEND : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool car_locked READ car_locked WRITE set_car_locked NOTIFY Car_is_locked)

private:
    bool m_car_locked;

public:
    explicit BACKEND(QObject *parent = nullptr);
    bool car_locked();
    void set_car_locked(bool lock);
signals:
    void Car_is_locked();
    // ~BACKEND();
};