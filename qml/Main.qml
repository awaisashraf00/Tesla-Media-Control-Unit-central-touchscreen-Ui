import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 1280
    height: 720
    visible: true
    title: "Tesla"

    Rectangle {
        anchors.fill: parent

        gradient: Gradient {
            GradientStop { position: 0.0; color: "DarkGrey" }
            GradientStop { position: 1.0; color: "#666666" }
        }
    }

    BottomButtons {
        id: bottomBar
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 7
    }

    MapView {
        id: mapView
        backend: upper_control
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.35
        anchors.right: parent.right
        anchors.rightMargin: 9
        anchors.bottom: bottomBar.top
    }
    LeftDashboard{
        id: leftbar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: mapView.left
        anchors.bottom: bottomBar.top
    }
}
