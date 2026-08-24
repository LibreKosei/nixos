import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import Quickshell.Wayland
import qs.config
import qs.modules.common

PopupWindow {
    id: root

    color: "transparent"
    visible: States.showNC
    implicitWidth: background.implicitWidth + shadow.offset.x * 2
    implicitHeight: background.implicitHeight + shadow.offset.y * 2

    RectangularShadow {
        id: shadow
        visible: true
        anchors.fill: background
        offset.x: 4
        offset.y: 8
        radius: background.radius
        color: Colors.md3.shadow
    }

    Rectangle {
        id: background

        implicitWidth: 700
        implicitHeight: 500
        color: Colors.md3.background
        radius: General.radius.large
        border.width: 0.5
        border.color: Colors.md3.outline_variant

        FlexboxLayout {
            id: flexboxLayout

            anchors {
                fill: parent
                margins: General.margin.large
            }

            gap: General.spacing.medium
            justifyContent: FlexboxLayout.JustifySpaceBetween

            NotificationArea {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Calendar {
                Layout.fillHeight: true
            }
        }
    }
}
