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
    property bool showShadow: true
    implicitWidth: 350
    implicitHeight: content.implicitHeight + General.margin.medium * 2
    height: implicitHeight

    // Component.onCompleted: {
    //     console.log("Notification widget: height", implicitHeight)
    // }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: Notification.activate(root.wrapper.notificationID)
    }
    // Timer {
    //     interval: Math.max(0, root.wrapper.expiresAt - Date.now())
    //     running: root.wrapper.popup && root.wrapper.expiresAt > 0
    //     repeat: false
    //     onTriggered: Notification.discard(root.wrapper.notificationID)
    // }

    RectangularShadow {
        visible: root.showShadow
        anchors.fill: background
        offset.x: 4
        offset.y: 8
        radius: background.radius
        color: Colors.md3.shadow
    }

    Rectangle {
        id: background

        anchors.fill: parent
        color: Colors.md3.surface_container_high
        border.width: root.wrapper.urgency === "critical" ? 1.5 : 0.5
        border.color: root.wrapper.urgency === "critical"
            ? Colors.md3.error
            : Colors.md3.outline_variant
        radius: General.radius.xl
    }

    ColumnLayout {
        id: content

        anchors {
            margins: General.margin.medium
            top: parent.top
            right: parent.right
            left: parent.left
        }

        // direction: FlexboxLayout.Column
        // justifyContent: FlexboxLayout.JustifyStart
        // alignItems: FlexboxLayout.AlignStart
        spacing: General.spacing.medium

        RowLayout {
            id: header

            Layout.fillWidth: true
            // justifyContent: FlexboxLayout.JustifySpaceBetween

            MonoText {
                id: appName

                Layout.fillWidth: true
                text: root.wrapper.appName
                color: Colors.md3.on_surface_variant
            }

            MonoText {
                id: time

                text: Qt.formatDateTime(new Date(root.wrapper.time), "hh:mm")
                color: Colors.md3.on_surface_variant
            }
        }

        RowLayout {
            id: main

            // direction: FlexboxLayout.Row
            Layout.fillWidth: true
            // Layout.preferredHeight: 100
            // alignItems: FlexboxLayout.AlignStart
            // justifyContent: FlexboxLayout.JustifyStart
            spacing: General.spacing.small

            NotificationIcon {
                id: notificationImage

                wrapper: root.wrapper
                Layout.preferredHeight: 64
                Layout.preferredWidth: 64
                iconColor: Colors.md3.on_surface
            }

            ColumnLayout {
                id: sub

                // direction: FlexboxLayout.Column
                Layout.fillWidth: true
                // Layout.fillHeight: true
                spacing: General.spacing.small

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
                    // Layout.fillHeight: true
                    text: root.wrapper.body
                    font.pixelSize: 12
                    wrapMode: Text.Wrap
                    color: Colors.md3.on_surface_variant
                    verticalAlignment: Text.AlignTop
                    maximumLineCount: 5
                }
            }
        }
    }
}
