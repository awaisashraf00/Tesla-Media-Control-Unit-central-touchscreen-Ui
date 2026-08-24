import QtQuick
import QtLocation
import QtPositioning

Map {
    id: map

    MouseArea {
        anchors.fill: parent
        enabled: true
        preventStealing: true

        property real lastMouseX
        property real lastMouseY

        onPressed: function(mouse) {
            lastMouseX = mouse.x
            lastMouseY = mouse.y
        }

        onPositionChanged: function(mouse) {
            if (!pressed)
                return

            var deltaX = mouse.x - lastMouseX
            var deltaY = mouse.y - lastMouseY
            map.center = map.toCoordinate(Qt.point(
                map.width / 2 - deltaX,
                map.height / 2 - deltaY
            ))
            lastMouseX = mouse.x
            lastMouseY = mouse.y
        }
    }

    plugin: Plugin {
        name: "osm"
    }

    center: QtPositioning.coordinate(
        31.5204,
        74.3587
    )

    zoomLevel: 10

    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.35
        enabled: false
    }
}