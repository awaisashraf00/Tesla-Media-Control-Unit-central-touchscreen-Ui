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
        width: 350
        height: 30
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
    Rectangle{
        id: timing
        color:"Black"
        width : 85
        radius:15
        anchors.leftMargin: 10
        anchors.left: lock_unlock.right
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height - 4
            Text{
                text: backend ? backend.current_time : "Not uploaded"
                width:55
                font.bold: true
                color: "lightGreen"
                anchors.centerIn:parent
                
            }
    }
        
        Text{
            id: temprature
            font.bold: true
            text: backend.temprature + "*C"
            anchors.left: timing.right
            anchors.verticalCenter: parent.verticalCenter
            width: parent.height - 4
            anchors.leftMargin: 10
        }
        
        Image {
            id: profile
            anchors.left: temprature.right
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            width: parent.height - 4
            height: parent.height - 4
            source: "qrc:/teslapixel/user.png"
            fillMode: Image.PreserveAspectFit
        }
        Text{
            
            id: username
            font.bold: true
            text: backend.user_name
            anchors.left: profile.right
            anchors.verticalCenter: parent.verticalCenter
            width: parent.height - 4
            anchors.leftMargin: 10
        }
    }
}
