import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import Quickshell

RoundButton {
    id: root

    required property string iconName
    property real paddingSize: 6
    property real iconSize: 48
    property real borderSize: 2
    property color borderColor: "#8CCF7E"
    property color bgColor: "#232a2d"
    property string fallbackIconName: "image-missing"
    property color iconColor: "#67B0E8"

    // shadow appearance
    property color shadowColor: "#80000000"
    property real shadowBlur: 16
    property real shadowSpread: 0
    property point shadowOffset: Qt.point(0, 2)

    icon {
        source: Quickshell.iconPath(root.iconName, root.fallbackIconName)
        color: root.iconColor
        width: root.iconSize
        height: root.iconSize
    }

    radius: 12

    background: Item {
        implicitWidth: root.iconSize + root.paddingSize * 2
        implicitHeight: root.iconSize + root.paddingSize * 2

        RectangularShadow {
            anchors.fill: bgRect
            radius: bgRect.radius
            color: root.shadowColor
            blur: root.shadowBlur
            spread: root.shadowSpread
            offset: root.shadowOffset
        }

        Rectangle {
            id: bgRect
            anchors.fill: parent
            radius: root.radius
            color: root.bgColor
            border {
                color: root.borderColor
                width: root.borderSize
            }
        }
    }
}
