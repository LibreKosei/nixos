import QtQuick
import QtQuick.Effects
import qs.config

RectangularShadow {
    id: shadow

    property real elevation: 0.5
    property real elevationScale: 8

    offset.x: elevation * elevationScale
    offset.y: elevation * elevationScale * 2
    color: Colors.md3.shadow
}
