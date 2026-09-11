import QtQuick 2.15
import QtQuick.Window 2.15

Item{
    id : homespace

    property bool homePopupVisible: false
    property int  margin_in_between: 20

    Rectangle{
        id: homePopup
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: homespace.width * 0.10
        anchors.rightMargin: homespace.width * 0.10
        height: homespace.height
        y: homespace.homePopupVisible ? 0 : homespace.height
        opacity: homespace.homePopupVisible ? 1 : 0
        visible: opacity > 0
        z: 100
        color: "transparent"
        scale: 1
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#b3242526" }
            GradientStop { position: 1.0; color: "#d9000000" }
        }
        border.color: "#66888888"
        border.width: 2
        radius: 20

        Image{
            id : settings_button
            source: "qrc:/teslapixel/settings.png"
            fillMode: Image.PreserveAspectFit
            width : parent.width * 0.10 
            height : parent.height * 0.10
            anchors{
                left:parent.left
                top:parent.top
                leftMargin : margin_in_between
                topMargin:margin_in_between
            }
        }

        Image{
            id : signal_button
            source: "qrc:/teslapixel/wi-fi.png"
            fillMode: Image.PreserveAspectFit
            width : parent.width * 0.10 
            height : parent.height * 0.10
            anchors{
                left:settings_button.right
                top:parent.top
                leftMargin : margin_in_between
                topMargin:margin_in_between
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