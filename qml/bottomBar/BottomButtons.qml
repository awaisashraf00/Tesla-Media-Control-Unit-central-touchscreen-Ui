import QtQuick 2.15
import QtQuick.Window 2.15

Item {

    id : bottomBar
    height: 50

    Rectangle {
        anchors.fill: parent
        radius: 8
        clip: true

        gradient: Gradient {
            GradientStop { position: 0.0; color: '#898d92' }
            GradientStop { position: 1.0; color: "#000000" }
        }
        Image {
            id: homebutton
            source: "qrc:/teslapixel/home.png"
            anchors.leftMargin: 10
            width: parent.height - 8
            height: parent.height - 8
            anchors.centerIn: parent
            anchors.verticalCenter : parent.verticalCenter
            fillMode: Image.PreserveAspectFit
        }
        
        Image {
            id:carbutton
            anchors.left: parent.left
            anchors.leftMargin : 30
            anchors.verticalCenter : parent.verticalCenter
            width: parent.height - 8
            height: parent.height - 8
            source: "qrc:/teslapixel/car-rear.png"
            fillMode: Image.PreserveAspectFit
        }
    }



}