#include <Backend.h>
#include <temprature.h>
#include <MusicController.h>
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
    TEMPRATURE_CONTROLS temp_unit;
    MusicController music_controller;
    //next compelete search bar fully
    engine.rootContext()->setContextProperty("upper_control", &upper_controls);
    engine.rootContext()->setContextProperty("Temprature_Controls", &temp_unit);
    engine.rootContext()->setContextProperty("musicController", &music_controller);
    engine.loadFromModule("TeslaMCU", "Main");
    if (engine.rootObjects().isEmpty()){return -1;}

    return app.exec();
}
