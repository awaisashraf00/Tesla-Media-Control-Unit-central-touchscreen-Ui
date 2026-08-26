import QtQuick
import QtLocation
import QtPositioning

Map {
    id: map

    property var backend

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
        122.1430,
        37.4419
    )

    zoomLevel: 10


    UpperControls {
        id: upperControls
        backend: map.backend
        z: 1
    }
    
    Searchbar {
        id: searcharea
        backend: map.backend
        anchors.left: map.left
        anchors.top: map.top
        anchors.leftMargin: 10
        anchors.topMargin: 50
        z: 1
    }
    
    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.05
        enabled: false
    }
}