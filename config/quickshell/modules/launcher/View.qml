import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import qs.services
import qs.modules.common
import qs.settings
import qs.config

GridView {
    id: root

    property real columns: 5

    clip: true
    model: Apps.sortedEntries
    implicitWidth: columns * cellWidth
    focus: true
    keyNavigationEnabled: true

    cellWidth: 150
    cellHeight: 180

    delegate: AppDelegate {
        id: appDelegate

        entry: modelData
        isCurrent: GridView.isCurrentItem
    }
}
