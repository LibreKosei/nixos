import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.services
import qs.config

PanelWindow {
    id: root

    implicitHeight: popupList.implicitHeight
    implicitWidth: popupList.implicitWidth
    WlrLayershell.layer: WlrLayer.Overlay
    visible: true 
    color: "transparent"
    anchors {
        top: true
        right: true
    }

    property var popups: {
        Notification.revision
        const arr = []
        const list = Notification.notifications
        for (let i = 0; i < list.count; i++) {
            const w = list.get(i).wrapper
            if (w.popup) arr.push(w)
        }

        return arr
    }

    ListView {
        id: popupList

        anchors {
            topMargin: General.margin.large
            top: parent.top
            right: parent.right
            left: parent.left
        }
        add: Transition {
            NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 220; easing.type: Easing.OutCubic }
        }
        remove: Transition {
            NumberAnimation { property: "opacity"; to: 0; duration: 160; easing.type: Easing.InCubic }
        }
        displaced: Transition {
            NumberAnimation { properties: "y"; duration: 200; easing.type: Easing.OutCubic }
        }
        spacing: 8
        implicitWidth: 500
        implicitHeight: contentHeight + anchors.topMargin + 4 * count
        model: Notification.popups
        delegate: Notif {
            wrapper: modelData
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
