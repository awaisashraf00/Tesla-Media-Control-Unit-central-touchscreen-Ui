#include <Backend.h>
#include <QQmlContext>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
// #include <QTextStream>
// #include <cstdlib>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    BACKEND upper_controls;
    engine.loadFromModule("TeslaMCU", "Main");
    if (engine.rootObjects().isEmpty()){return -1;}
    engine.rootContext()->setContextProperty("upper_control", &upper_controls);

    return app.exec();
}
