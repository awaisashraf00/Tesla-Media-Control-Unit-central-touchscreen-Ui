import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 1280
    height: 720
    visible: true
    title: "Tesla"

    BottomButtons {
        id: bottomBar
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 7
    }

    MapView {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.35
        anchors.right: parent.right
        anchors.bottom: bottomBar.top
    }
}
