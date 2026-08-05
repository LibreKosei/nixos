import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.modules.common
import qs.services
import qs.settings
import qs.config

Clickable {
    id: root

    property DesktopEntry entry
    property bool isCurrent: false
    bgColor: "transparent"
    showShadow: false
    padding: General.padding.large
    onClicked: () => {
        Apps.launch(entry)
        Config.persistent.showLauncher = false
    }

    contentItem: Item {
        id: content

        implicitWidth: 100
        implicitHeight: 120

        Rectangle {
            id: background

            anchors.fill: parent
            color: "transparent"
            radius: General.radius.medium
            border.width: root.isCurrent ? 2 : 0
            border.color: root.isCurrent ? Config.blue : "transparent"
        }

        FlexboxLayout {
            id: layout

            anchors.fill: parent
            direction: FlexboxLayout.Column
            justifyContent: FlexboxLayout.JustifySpaceEvenly
            alignItems: FlexboxLayout.AlignCenter
            gap: General.spacing.medium

            Icon {
                id: icon

                iconName: root.entry?.icon
                implicitSize: 48
                layer.enabled: false
            }

            MonoText {
                id: monoText

                text: root.entry?.name
                wrapMode: Text.Wrap
                Layout.alignment: Qt.AlignHCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: Colors.md3.on_surface
            }
        }
    }
}
