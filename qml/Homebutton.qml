import QtQuick 2.15
import QtQuick.Window 2.15

Item{
    id : homespace

    property bool homePopupVisible: false

    Rectangle{
        id: homePopup
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: homespace.width * 0.10
        anchors.rightMargin: homespace.width * 0.10
        height: homespace.height
        y: homespace.homePopupVisible ? 0 : homespace.height
        visible: opacity > 0
        z: 100
        color: "transparent"
        opacity: homespace.homePopupVisible ? 1 : 0
        scale: 1
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#b3242526" }
            GradientStop { position: 1.0; color: "#d9000000" }
        }
        border.color: "#66888888"
        border.width: 2
        radius: 20
        
        Behavior on y {
            NumberAnimation { duration: 280; easing.type: Easing.OutCubic }
        }

        Behavior on opacity {
            NumberAnimation { duration: 220; easing.type: Easing.OutCubic }
        }

    }
}