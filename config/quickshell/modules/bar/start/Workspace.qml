import QtQuick
import Quickshell
import Quickshell.WindowManager
import qs.services
import qs.settings

ListView {
    id: root

    model: Workspace.workspaces
    orientation: Qt.Horizontal
    spacing: Config.spacing.small

    delegate: WorkspaceDelegate {
        required property var modelData
        ws: modelData

        implicitHeight: ListView.view.height
        implicitWidth: this.implicitHeight
    }
}
