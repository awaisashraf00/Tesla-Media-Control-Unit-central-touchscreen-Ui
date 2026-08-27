import QtQuick 2.15
import QtQuick.Window 2.15


Item {
    id: musicBar

    width: parent ? parent.width : 0
    height: parent ? parent.height * 0.15 : 0
    property bool isPlaying: false
    property int currentTrack: 0
    property int trackCount: 3

    Rectangle {
        id: musicbar

        anchors.fill: parent
        color: "#C7C5C5"
        radius: 15
        border.color: "#888888"
        border.width: 5

        Row {
            anchors.centerIn: parent
            spacing: 24

            Image {
                id: previousButton

                width: musicbar.height - 50
                height: width
                source: "qrc:/teslapixel/previous.png"
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        musicBar.currentTrack = musicBar.currentTrack > 0
                                ? musicBar.currentTrack - 1
                                : musicBar.trackCount - 1
                    }
                }
            }

            Image {
                id: playButton

                width: musicbar.height - 50
                height: width
                source: musicBar.isPlaying
                        ? "qrc:/teslapixel/pause.png"
                        : "qrc:/teslapixel/play-buttton.png"
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    anchors.fill: parent
                    onClicked: musicBar.isPlaying = !musicBar.isPlaying
                }
            }

            Image {
                id: nextButton

                width: musicbar.height - 50
                height: width
                source: "qrc:/teslapixel/next.png"
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        musicBar.currentTrack = musicBar.currentTrack + 1
                                < musicBar.trackCount
                                ? musicBar.currentTrack + 1
                                : 0
                    }
                }
            }
        }
    }
}