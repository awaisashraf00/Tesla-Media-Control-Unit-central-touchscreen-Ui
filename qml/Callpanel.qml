import QtQuick 2.15
import QtQuick.Window 2.15

Item{
    id : callspace
    property bool callbuttonvisible: false
    property string dialedNumber: ""
    
    Rectangle {
        width: callspace.width * 0.25
        height: callspace.height * 0.70
        anchors.horizontalCenter: callspace.horizontalCenter
        y: callspace.callbuttonvisible ? callspace.height - height : callspace.height
        opacity: callspace.callbuttonvisible ? 1 : 0

        visible: opacity > 0

        z: 101
        color: "transparent"
        scale: 1
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#b3242526" }
            GradientStop { position: 1.0; color: "#d9000000" }
        }
        border.color: "#66888888"
        border.width: 2
        radius: 20

        Text {
            id: title
            anchors.top: parent.top
            anchors.topMargin: 18
            anchors.horizontalCenter: parent.horizontalCenter
            text: "PHONE"
            color: "#d7dcda"
            font.family: "Avenir Next"
            font.pixelSize: 16
            font.bold: true
            font.letterSpacing: 2
        }

        Text {
            id: numberDisplay
            anchors.top: title.bottom
            anchors.topMargin: 12
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 36
            text: callspace.dialedNumber || "Enter number"
            color: callspace.dialedNumber ? "#ffffff" : "#7f8885"
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideLeft
            font.family: "Avenir Next"
            font.pixelSize: 24
            font.bold: true
        }

        Grid {
            id: keypad
            columns: 3
            rows: 4
            spacing: 8
            anchors.top: numberDisplay.bottom
            anchors.topMargin: 16
            anchors.horizontalCenter: parent.horizontalCenter

            Repeater {
                model: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "*", "0", "#"]

                delegate: Rectangle {
                    width: ((callspace.width * 0.5 - 48) / 3) * 0.30
                    height: width
                    radius: 10
                    color: "transparent"
                    border.color: "#68726f"
                    border.width: 1

                    Text {
                        anchors.centerIn: parent
                        text: modelData
                        color: "#f2f5f3"
                        font.family: "Avenir Next"
                        font.pixelSize: 23
                        font.bold: true
                    }

                    MouseArea {
                        id: keypadMouse
                        anchors.fill: parent
                        onClicked: callspace.dialedNumber += modelData
                    }
                }
            }
        }

        Rectangle {
            width: 82
            height: 34
            anchors.top: keypad.bottom
            anchors.topMargin: 12
            anchors.horizontalCenter: parent.horizontalCenter
            radius: 17
            color: "#3f8f70"

            Text {
                anchors.centerIn: parent
                text: "CLEAR"
                color: "white"
                font.family: "Avenir Next"
                font.pixelSize: 13
                font.bold: true
                font.letterSpacing: 1
            }

            MouseArea {
                anchors.fill: parent
                onClicked: callspace.dialedNumber = ""
            }
        }

        Behavior on y {
            NumberAnimation { duration: 280; easing.type: Easing.OutCubic }
        }

        Behavior on opacity {
            NumberAnimation { duration: 220; easing.type: Easing.OutCubic }
        }
    }

}