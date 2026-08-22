#include <QQmlContext>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
// #include <QTextStream>
// #include <cstdlib>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    engine.loadFromModule("TeslaMCU", "Main");
    if (engine.rootObjects().isEmpty()){return -1;}

    return app.exec();
}
