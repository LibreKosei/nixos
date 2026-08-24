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

    ListView {
        id: popupList

        anchors {
            topMargin: General.margin.large
            top: parent.top
            right: parent.right
            left: parent.left
        }

        spacing: 8
        implicitWidth: 500
        implicitHeight: 0 < count ? contentHeight + anchors.topMargin + 20 : 0
        clip: true
        interactive: false
        model: Notification.popups
        delegate: Notif {
            wrapper: modelData
            width: 350
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            Timer {
                interval: Math.max(0, wrapper.expiresAt - Date.now())
                running: wrapper.popup && wrapper.expiresAt > 0
                repeat: false
                onTriggered: Notification.removePopup(wrapper.notificationID)
            }
        }

        // onImplicitHeightChanged: {
        //     console.log("Notification popup list height: ", implicitHeight)
        // }
    }

    // onImplicitHeightChanged: {
    //     console.log("Notification popup window height: ", implicitHeight)
    // }
}
