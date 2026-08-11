import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import qs.settings
import qs.config
import qs.services
import qs.modules.common

Item {
    id: root

    property var wrapper 
    implicitWidth: 350
    implicitHeight: content.implicitHeight

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: Notification.discard(root.wrapper.notificationID)
    }
    // Timer {
    //     interval: Math.max(0, root.wrapper.expiresAt - Date.now())
    //     running: root.wrapper.popup && root.wrapper.expiresAt > 0
    //     repeat: false
    //     onTriggered: Notification.discard(root.wrapper.notificationID)
    // }

    RectangularShadow {
        visible: true
        anchors.fill: background
        offset.x: 8
        offset.y: 4
        radius: background.radius
        color: Colors.md3.shadow
    }
    Rectangle {
        id: background

        anchors.fill: parent
        color: Colors.md3.surface_container_high
        // color: "transparent"
        border.width: root.wrapper.urgency === "critical" ? 1.5 : 0.5
        border.color: root.wrapper.urgency === "critical"
            ? Colors.md3.error
            : Colors.md3.outline_variant
        radius: General.radius.xl
        layer.enabled: true
    }

    // MultiEffect {
    //     id: blurredBg
    //     source: background
    //     anchors.fill: background
    //     blur: 1.0
    //     saturation: 0.2
    //     brightness: 0.4
    //     blurMax: 16
    // }

    
    FlexboxLayout {
        id: content

        anchors {
            margins: General.margin.medium
            top: parent.top
            right: parent.right
            left: parent.left
        }

        direction: FlexboxLayout.Column
        justifyContent: FlexboxLayout.JustifyStart
        alignContent: FlexboxLayout.AlignStart
        gap: 0

        FlexboxLayout {
            id: header

            Layout.fillWidth: true
            Layout.preferredHeight: 50
            justifyContent: FlexboxLayout.JustifySpaceBetween

            MonoText {
                id: appName

                Layout.fillWidth: true
                text: root.wrapper.appName
                color: Colors.md3.on_surface_variant
            }

            MonoText {
                id: time

                text: root.wrapper.date + " : " + Qt.formatDateTime(new Date(root.wrapper.time), "hh:mm")
                color: Colors.md3.on_surface_variant
            }
        }


        FlexboxLayout {
            id: main

            direction: FlexboxLayout.Row
            Layout.fillWidth: true
            Layout.preferredHeight: 100
            alignItems: FlexboxLayout.AlignStart
            justifyContent: FlexboxLayout.AlignStart
            gap: General.spacing.small

            NotificationIcon {
                id: notificationImage

                wrapper: root.wrapper
                Layout.preferredHeight: 64
                Layout.preferredWidth: 64
                iconColor: Colors.md3.on_surface
            }

            FlexboxLayout {
                id: sub

                direction: FlexboxLayout.Column
                Layout.fillWidth: true
                Layout.fillHeight: true
                gap: General.spacing.small

                MonoText {
                    id: title
                    
                    font.pixelSize: 16
                    font.bold: true
                    Layout.fillWidth: true
                    color: Colors.md3.on_surface
                    text: root.wrapper.summary
                }

                MonoText {
                    id: body

                    Layout.fillWidth: true
                    text: root.wrapper.body
                    wrapMode: Text.WordWrap
                    color: Colors.md3.on_surface_variant
                }
            }
        }
    }
}
