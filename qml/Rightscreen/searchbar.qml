import QtQuick 2.15
import QtQuick.Window 2.15


Item{
    id: searchRoot
    property var backend
    signal querySubmitted(string query)
    width: 280
    height: 36
    z: 1

    Rectangle{
        id : searchbar
        color: "#C7C5C5"
        radius: 8
        anchors.fill: parent
        border.color: "#888888"
        border.width: 1

        Text {
            anchors.left: parent.left
            anchors.leftMargin: 14
            anchors.verticalCenter: parent.verticalCenter
            text: "Search anything"
            color: "#525252"
            visible: searchInput.text.length === 0
            z: 1
        }
        
        TextInput {
            id: searchInput
            anchors.fill: parent
            anchors.leftMargin: 14
            anchors.rightMargin: 14
            color: "#202020"
            font.pixelSize: 14
            verticalAlignment: TextInput.AlignVCenter
            clip: true
            selectByMouse: true

            onAccepted: {
                if (text.trim().length > 0)
                    searchRoot.querySubmitted(text.trim())
            }

            Keys.onEscapePressed: {
                text = ""
                focus = false
            }
        }


        MouseArea {
            anchors.fill: parent
            z: -1
            onClicked: searchInput.forceActiveFocus()
        }
    }
}