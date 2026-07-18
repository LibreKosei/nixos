import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts

Button {
    id: root

    // General
    property real radius: 12
    property color bgColor: "#232a2d"
    property real space: 6
    default property alias content: layout.data

    // Shadow
    property bool showShadow: true
    property color shadowColor: "#80000000"
    property real shadowBlur: 16
    property real elevation: 0.5
    property real elevationScale: 4

    padding: 6

    contentItem: Item {

        implicitWidth: layout.width
        implicitHeight: layout.height

        FlexboxLayout {
            id: layout
            
            direction: FlexboxLayout.Row
            justifyContent: FlexboxLayout.JustifySpaceEvenly
            alignItems: FlexboxLayout.AlignCenter
            gap: space
        }
    }

    background: Item {
        RectangularShadow {
            visible: root.showShadow
            anchors.fill: parent
            offset.x: root.elevation * root.elevationScale
            offset.y: root.elevation * root.elevationScale * 2
            radius: root.radius
            color: root.shadowColor
        }

        Rectangle {
            id: bg
            anchors.fill: parent
            radius: root.radius
            color: root.bgColor
        }
    }
}
