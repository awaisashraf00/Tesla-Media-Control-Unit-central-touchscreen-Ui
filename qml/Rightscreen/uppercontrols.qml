import QtQuick 2.15
import QtQuick.Window 2.15

Item {
    property var backend
    width: 300
    height: 30
    z: 1

    Rectangle {
        id: upperbuttons
        radius: 15
        color: "#C7C5C5"
        width: 300
        height: 20
        anchors {
            left: parent.left
            top: parent.top
            leftMargin: 10
            topMargin: 10
        }

        Image {
            id: lock_unlock
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            width: parent.height - 4
            height: parent.height - 4
            source: (backend ? (backend.car_locked ? "qrc:/teslapixel/lock-2.png" : "qrc:/teslapixel/lock-3.png") : "qrc:/teslapixel/lock-2.png")
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill:parent
                onClicked:{
                    if (backend)
                        backend.car_locked = !backend.car_locked
                }
            }
        }

        Text{
            id: timing
            color: "#111111"
            font.bold: true
            text: backend ? backend.current_time : "Not uploaded"
            anchors.left: lock_unlock.right
            anchors.verticalCenter: parent.verticalCenter
            width:55
            height: parent.height - 4
            anchors.leftMargin: 10
        }
        
        Text{
            id: temprature
            font.bold: true
            text: backend.temprature + "*"
            anchors.left: timing.right
            anchors.verticalCenter: parent.verticalCenter
            width: parent.height - 4
            height: parent.height - 4
            anchors.leftMargin: 10
        }
        
        // Image {
        //     id: lock_unlock
        //     anchors.left: parent.left
        //     anchors.leftMargin: 10
        //     anchors.verticalCenter: parent.verticalCenter
        //     width: parent.height - 4
        //     height: parent.height - 4
        //     source: "qrc:/teslapixel/lock-2.png"
        //     fillMode: Image.PreserveAspectFit
        // }
    }
}
