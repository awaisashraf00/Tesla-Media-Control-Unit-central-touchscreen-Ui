import QtQuick 2.15
import QtQuick.Window 2.15

Item {

    id : leftscreen
    height: 50

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        Image {
            anchors.fill: parent
            anchors.margins: 20
            source: "qrc:/teslapixel/tesla.png"
            fillMode: Image.PreserveAspectFit
        }

    }
}