import QtQuick 2.15
import QtQuick.Window 2.15

Item {

    id : bottomBar
    height: 50

    property var temp_Unit

    Rectangle {
        anchors.fill: parent
        radius: 8
        clip: true
// 898d92
        gradient: Gradient {
            GradientStop { position: 0.0; color: '#242526' }
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

        Image {
            id:callbutton
            anchors.left: homebutton.right
            anchors.leftMargin : 40
            anchors.verticalCenter : parent.verticalCenter
            width: parent.height - 10
            height: parent.height - 10
            source: "qrc:/teslapixel/phone-call.png"
            fillMode: Image.PreserveAspectFit
        }
        
        Image {
            id: temptrature_buttons_l
            anchors.left: carbutton.right
            anchors.leftMargin : 200
            anchors.verticalCenter : parent.verticalCenter
            width: parent.height - 8
            height: parent.height - 8
            source: "qrc:/teslapixel/left-arrow.png"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill:parent
                onClicked:{
                    bottomBar.temp_Unit.decerment_temprature()
                }
            }
        }
        
        Image {
            id: temptrature_buttons_r
            anchors.right: homebutton.left
            anchors.rightMargin : 200
            anchors.verticalCenter : parent.verticalCenter
            width: parent.height - 8
            height: parent.height - 8
            source: "qrc:/teslapixel/right-arrow.png"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill:parent
                onClicked:{
                    bottomBar.temp_Unit.incerment_temprature()
                }
            }       
        }

        Text {
            text: bottomBar.temp_Unit ? bottomBar.temp_Unit.current_temp + "°" : "--°"

            anchors.left: temptrature_buttons_l.right
            anchors.right: temptrature_buttons_r.left
            anchors.leftMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            color: "#616362"
            font.pixelSize: 35
            font.bold: true
        }

        // #414347
    }



}