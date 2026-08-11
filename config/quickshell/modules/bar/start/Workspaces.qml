import QtQuick
import qs.services
import qs.config
import qs.modules.common
Item {
    id: root

    implicitWidth: workspaces.implicitWidth + General.margin.medium * 2
    implicitHeight: 48

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        radius: General.radius.medium
    }

    Row {
        id: workspaces

        anchors.centerIn: parent
        spacing: General.spacing.medium

        Repeater {
            model: Workspace.workspaces

            delegate: Rectangle {
                required property var modelData

                anchors.verticalCenter: parent.verticalCenter
                implicitWidth: modelData.active ? 20 : 8
                implicitHeight: modelData.active ? 10 : 8
                radius: 4

                color: modelData.active
                    ? Colors.palette.primary70
                    : Colors.md3.on_surface_variant

                HoverHandler {
                    cursorShape: Qt.PointingHandCursor
                }

                TapHandler {
                    onTapped: if (modelData.canActivate) modelData.activate()
                }
            }
        }
    }
}
