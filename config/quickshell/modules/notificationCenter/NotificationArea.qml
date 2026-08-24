import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import qs.settings
import qs.config
import qs.services
import qs.modules.common
import qs.modules.bar
import qs.modules.notification

Item {
    id: root

    implicitHeight: 450
    implicitWidth: 300

    Rectangle {
        id: background

        anchors.fill: parent
        color: "transparent"
        radius: General.radius.medium
    }

    ColumnLayout {
        id: columnLayout

        spacing: General.spacing.medium

        anchors {
            fill: parent
            margins: General.margin.medium
        }

        RowLayout {
            id: header

            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft

            MonoText {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                color: Colors.md3.on_surface
                text: `${Notification.notifications.count} notifications`
            }

            Clicker {
                id: clearButton

                backgroundColor: Colors.md3.surface_container_high

                MonoText {
                    text: "Clear"  
                    color: Colors.md3.on_surface
                }

                Icon {
                    iconName: "user-trash-symbolic"
                    iconColor: Colors.md3.on_surface
                }

                TapHandler {
                    onTapped: Notification.discardAll()
                }
            }
        }

        ListView {
            id: notifications

            visible: 0 < Notification.notifications.count
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: Notification.notifications
            clip: true
            spacing: General.spacing.medium
            delegate: Notif {
                wrapper: modelData
                implicitWidth: parent.width
                showShadow: false

                anchors {
                    horizontalCenter: parent?.horizontalCenter
                }
            }
        }

        // Icon {
        //     id: zeroNotificationIndicator
        //
        //     visible: 0 === Notification.notifications.count
        //     Layout.fillWidth: true
        //     Layout.fillHeight: true
        //     iconName: "dialog-information-symbolic"
        //     iconColor: Colors.md3.error
        // }
        //
        // MonoText {
        //     id: zeroNotificationText
        //
        //     visible: 0 === Notification.notifications.count
        //     Layout.fillWidth: true
        //     text: "No notifications"
        // }
    }
}
