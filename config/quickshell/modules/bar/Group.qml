import Quickshell
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

    // Text props
    property color textColor: "#DADADA"
    property string fontFamily: "JetBrainsMono Nerd Font"
    property real fontSize: 12

    // Icon properties
    property string iconName
    property color iconColor: "#dadada"
    property real iconSize: 48

    // Shadow
    property color shadowColor: "#80000000"
    property real shadowBlur: 16
    property real elevation: 0.5
    property real elevationScale: 4

    TextMetrics {
        id: textMetric
        font: root.font
        text: "WWWW"
    }

    padding: 6

    font {
        family: root.fontFamily
        pixelSize: root.fontSize
    }

    contentItem: Item {

        implicitWidth: layout.width
        implicitHeight: layout.height

        FlexboxLayout {
            id: layout
            
            direction: FlexboxLayout.Row
            justifyContent: FlexboxLayout.JustifySpaceEvenly
            alignItems: FlexboxLayout.AlignCenter
            gap: root.text == "" ? 0 : 6
            
            IconImage {
                id: icon
                source: Quickshell.iconPath(root.iconName, "image-missing-symbolic")
                implicitSize: root.iconSize
                layer.enabled: true
                layer.effect: MultiEffect {
                    source: icon
                    brightness: 0.8
                    colorization: 1.0
                    colorizationColor: root.iconColor
                }
            }

            Text {
                id: text
                visible: root.text != ""
                text: root.text
                font: root.font
                color: root.textColor
                Layout.preferredWidth: textMetric.width
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    background: Item {
        RectangularShadow {
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
