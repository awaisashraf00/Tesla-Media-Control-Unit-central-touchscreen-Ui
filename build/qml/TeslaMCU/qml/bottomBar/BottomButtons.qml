import QtQuick 2.15
import QtQuick.Window 2.15

Item {

    id : bottomBar
    height: 50

    Rectangle {
        anchors.fill: parent
        radius: 8

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#1f2937" }
            GradientStop { position: 1.0; color: "#000000" }
        }
    }
}