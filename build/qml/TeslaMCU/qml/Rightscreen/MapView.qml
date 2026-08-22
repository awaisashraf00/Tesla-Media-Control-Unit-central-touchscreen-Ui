import QtQuick
import QtLocation
import QtPositioning

Map {
    id: map

    plugin: Plugin {
        name: "osm"
    }

    center: QtPositioning.coordinate(
        31.5204,
        74.3587
    )

    zoomLevel: 14
}