import QtQuick
import Quickshell
import Quickshell.WindowManager
import qs.services
import qs.settings
import qs.config

ListView {
    id: root

    model: Workspace.workspaces
    orientation: Qt.Horizontal
    spacing: General.spacing.small

    delegate: WorkspaceDelegate {
        required property var modelData
        ws: modelData

        implicitHeight: ListView.view.height
        implicitWidth: this.implicitHeight
    }

    Component.onCompleted: console.log("Workspace Icons: height", implicitHeight)
}
