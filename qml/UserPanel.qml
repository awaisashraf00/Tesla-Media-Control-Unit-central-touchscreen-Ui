import QtQuick 2.15

Rectangle {
    id: user_panel
    width: parent.width * 0.7
    height: parent.height * 0.7
    color: "transparent"

    property bool visible_panel: false
    property string panel_mode: ""
    property var backend

    opacity: visible_panel ? 1 : 0
    visible: opacity > 0

    border.color: "#66888888"
    border.width: 2
    radius: 20

    gradient: Gradient {
        GradientStop { position: 0.0; color: "#b3242526" }
        GradientStop { position: 1.0; color: "#d9000000" }
    }

    Text {
        id: user_panel_title
        anchors.top: parent.top
        anchors.topMargin: 18
        anchors.horizontalCenter: parent.horizontalCenter
        text: panel_mode === "add" ? "ADD NEW USER" : panel_mode === "info" ? "USER INFORMATION" : "PROFILE"
        color: "#d6d6d6"
        font.bold: true
        font.pixelSize: 22
    }

    Rectangle {
        id: add_user_button
        width: parent.width * 0.36
        height: 48
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.08
        anchors.top: user_panel_title.bottom
        anchors.topMargin: 22
        radius: 10
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#b3242526" }
            GradientStop { position: 1.0; color: "#d9000000" }
        }
        border.color: "#66888888"
        border.width: 1

        Text {
            anchors.centerIn: parent
            text: "ADD NEW USER"
            color: "#d6d6d6"
            font.bold: true
            font.pixelSize: 14
        }

        MouseArea {
            anchors.fill: parent
            onClicked: panel_mode = "add"
        }
    }

    Rectangle {
        id: existing_user_button
        width: parent.width * 0.36
        height: 48
        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.08
        anchors.top: user_panel_title.bottom
        anchors.topMargin: 22
        radius: 10
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#b3242526" }
            GradientStop { position: 1.0; color: "#d9000000" }
        }
        border.color: "#66888888"
        border.width: 1

        Text {
            anchors.centerIn: parent
            text: "EXISTING USER"
            color: "#d6d6d6"
            font.bold: true
            font.pixelSize: 14
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                panel_mode = "info"
                if (backend) {
                    backend.Load_Users()
                }
            }
        }
    }

    Column {
        id: add_user_form
        visible: panel_mode === "add"
        anchors.top: add_user_button.bottom
        anchors.topMargin: 18
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.72
        spacing: 10

        TextInput {
            id: new_user_name
            width: parent.width
            height: 38
            color: "#eeeeee"
            font.pixelSize: 15
            verticalAlignment: TextInput.AlignVCenter
            leftPadding: 12
            clip: true
            text: ""
            selectByMouse: true
            Rectangle { anchors.fill: parent; z: -1; radius: 7; color: "#66242526"; border.color: "#66888888";anchors.verticalCenter: parent.verticalCenter }
            Text { anchors.left: parent.left; anchors.leftMargin: 12; anchors.verticalCenter: parent.verticalCenter; text: "Name"; color: "#888888"; visible: !parent.text }
        }

        TextInput {
            id: new_user_email
            width: parent.width
            height: 38
            color: "#eeeeee"
            font.pixelSize: 15
            verticalAlignment: TextInput.AlignVCenter
            leftPadding: 12
            clip: true
            text: ""
            selectByMouse: true
            Rectangle { anchors.fill: parent; z: -1; radius: 7; color: "#66242526"; border.color: "#66888888" ;anchors.verticalCenter: parent.verticalCenter}
            Text { anchors.left: parent.left; anchors.leftMargin: 12; anchors.verticalCenter: parent.verticalCenter; text: "Email"; color: "#888888"; visible: !parent.text }
        }

        TextInput {
            id: new_user_password
            width: parent.width
            height: 38
            color: "#eeeeee"
            font.pixelSize: 15
            verticalAlignment: TextInput.AlignVCenter
            leftPadding: 12
            clip: true
            echoMode: TextInput.Password
            text: ""
            selectByMouse: true
            Rectangle { anchors.fill: parent; z: -1; radius: 7; color: "#66242526"; border.color: "#66888888" ;anchors.verticalCenter: parent.verticalCenter}
            Text { anchors.left: parent.left; anchors.leftMargin: 12; anchors.verticalCenter: parent.verticalCenter; text: "Password"; color: "#888888"; visible: !parent.text }
        }

        Rectangle {
            width: parent.width
            height: 42
            radius: 8
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#b3242526" }
                GradientStop { position: 1.0; color: "#d9000000" }
            }
            border.color: "#66888888"

            Text { anchors.centerIn: parent; text: "SAVE USER"; color: "#d6d6d6"; font.bold: true }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (backend && new_user_name.text && new_user_email.text && new_user_password.text) {
                        backend.Add_User(new_user_name.text, new_user_email.text, new_user_password.text)
                        new_user_name.text = ""
                        new_user_email.text = ""
                        new_user_password.text = ""
                        panel_mode = "info"
                        backend.Load_Users()
                    }
                }
            }
        }
    }

    Column {
        visible: panel_mode === "info"
        anchors.top: add_user_button.bottom
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.72
        height: parent.height - anchors.topMargin - 30
        spacing: 14

        ListView {
            anchors.fill: parent
            clip: true
            spacing: 8
            model: backend ? backend.users : []

            delegate: Rectangle {
                width: ListView.view.width
                height: 58
                radius: 8
                color: "#66242526"
                border.color: "#66888888"

                Column {
                    anchors.left: parent.left
                    anchors.leftMargin: 14
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 3

                    Text {
                        text: modelData.name
                        color: "#d6d6d6"
                        font.bold: true
                        font.pixelSize: 16
                    }

                    Text {
                        text: modelData.email
                        color: "#aaaaaa"
                        font.pixelSize: 13
                    }
                }
            }

            Text {
                anchors.centerIn: parent
                visible: parent.count === 0
                text: "No users found"
                color: "#aaaaaa"
                font.pixelSize: 15
            }
        }
    }

    Behavior on opacity {
        NumberAnimation { duration: 220; easing.type: Easing.OutCubic }
    }
}
