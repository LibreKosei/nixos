import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import qs.services

ListView {
    id: root

    spacing: 8
    clip: true
    model: Apps.sortedEntries
    layoutDirection: Qt.LeftToRight
    orientation: Qt.Horizontal
    focus: true

    delegate: EntryDelegate {
        id: card

        required property DesktopEntry modelData
        required property int index

        entry: modelData
        anchors.verticalCenter: parent?.verticalCenter
        anchors.verticalCenterOffset: ListView.isCurrentItem ? -20 : 0
        z: ListView.isCurrentItem ? 1 : 0

        Behavior on anchors.verticalCenterOffset {
            NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
        }
    }

    Item {
        anchors.fill: parent

        WheelHandler {
            acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
            onWheel: (event) => {
                // console.log("wheel", event.angleDelta.y)
                if (event.angleDelta.y < 0)
                    root.currentIndex = Math.min(root.currentIndex + 1, root.count - 1)
                else if (event.angleDelta.y > 0)
                    root.currentIndex = Math.max(root.currentIndex - 1, 0)
                event.accepted = true
            }
        }
    }
}
