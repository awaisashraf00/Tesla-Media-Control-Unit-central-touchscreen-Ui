#include<QObject>

class BACKEND : public QObject
{
    Q_OBJECT

private:
public:
    explicit BACKEND(QObject *parent = nullptr);
    ~BACKEND();
signals:

};