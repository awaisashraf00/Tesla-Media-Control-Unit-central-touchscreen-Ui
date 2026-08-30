import QtQuick 2.15
import QtQuick.Window 2.15


Item {
    id: musicBar

    width: parent ? parent.width : 0
    height: parent ? parent.height * 0.15 : 0

    Rectangle {
        id: musicbar

        anchors.fill: parent
        color: "#C7C5C5"
        radius: 15
        border.color: "#888888"
        border.width: 5

        Column {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 5

            // Track info section
            Item {
                width: parent.width
                height: parent.height * 0.35

                Column {
                    anchors.centerIn: parent
                    spacing: 2

                    Text {
                        id: trackTitle
                        text: musicController.currentTrackTitle
                        font.pixelSize: 16
                        font.bold: true
                        color: "#1a1a1a"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Text {
                        id: artistName
                        text: musicController.currentArtist
                        font.pixelSize: 12
                        color: "#4a4a4a"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }

            // Progress bar section
            Item {
                width: parent.width
                height: parent.height * 0.15

                Row {
                    anchors.fill: parent
                    spacing: 10

                    Text {
                        id: currentTime
                        text: formatTime(musicController.position)
                        font.pixelSize: 10
                        color: "#2a2a2a"
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Rectangle {
                        id: progressBackground
                        width: parent.width - currentTime.width - totalTime.width - 20
                        height: 6
                        color: "#888888"
                        radius: 3
                        anchors.verticalCenter: parent.verticalCenter

                        Rectangle {
                            id: progressBar
                            width: musicController.duration > 0
                                   ? parent.width * (musicController.position / musicController.duration)
                                   : 0
                            height: parent.height
                            color: "#1a1a1a"
                            radius: 3
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                var newPosition = (mouse.x / width) * musicController.duration
                                musicController.seek(newPosition)
                            }
                        }
                    }

                    Text {
                        id: totalTime
                        text: formatTime(musicController.duration)
                        font.pixelSize: 10
                        color: "#2a2a2a"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

            // Control buttons section
            Item {
                width: parent.width
                height: parent.height * 0.5

                Row {
                    id: controlsRow
                    anchors.centerIn: parent
                    spacing: 14
                    height: 26

                    Image {
                        id: previousButton
                        width: 26
                        height: 26
                        source: "qrc:/teslapixel/previous.png"
                        fillMode: Image.PreserveAspectFit
                        anchors.verticalCenter: parent.verticalCenter

                        MouseArea {
                            anchors.fill: parent
                            onClicked: musicController.previous()
                        }
                    }

                    Image {
                        id: playButton
                        width: 32
                        height: 32
                        source: musicController.isPlaying
                                ? "qrc:/teslapixel/pause.png"
                                : "qrc:/teslapixel/play-buttton.png"
                        fillMode: Image.PreserveAspectFit
                        anchors.verticalCenter: parent.verticalCenter

                        MouseArea {
                            anchors.fill: parent
                            onClicked: musicController.playPause()
                        }
                    }

                    Image {
                        id: nextButton
                        width: 26
                        height: 26
                        source: "qrc:/teslapixel/next.png"
                        fillMode: Image.PreserveAspectFit
                        anchors.verticalCenter: parent.verticalCenter

                        MouseArea {
                            anchors.fill: parent
                            onClicked: musicController.next()
                        }
                    }
                }
            }
        }
    }

    function formatTime(milliseconds) {
        var seconds = Math.floor(milliseconds / 1000)
        var minutes = Math.floor(seconds / 60)
        seconds = seconds % 60
        return minutes + ":" + (seconds < 10 ? "0" : "") + seconds
    }
}
