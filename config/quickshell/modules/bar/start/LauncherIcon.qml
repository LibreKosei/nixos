import QtQuick
import QtQuick.Effects
import Quickshell
import qs.config
import qs.modules.common

Item {
    id: root

    RectangularShadow {
        id: shadow

        anchors.fill: content
        offset.x: 2
        offset.y: 4
        radius: content.radius
        color: Colors.md3.shadow
    }

    Rectangle {
        id: content

        anchors.fill: parent
        color: Colors.md3.tertiary_container
        radius: General.radius.medium

        TapHandler {
            id: tapHandler
            onTapped: States.showLauncher = !(States.showLauncher)
        }

        HoverHandler {
            id: hoverHandler
            cursorShape: Qt.PointingHandCursor
        }

        Icon {
            id: icon

            anchors.centerIn: parent
            iconName: "view-app-grid-symbolic"
            iconColor: Colors.md3.on_tertiary_container
        }
        Component.onCompleted: console.log("Launcher Icon: height", implicitHeight)

    }
}
