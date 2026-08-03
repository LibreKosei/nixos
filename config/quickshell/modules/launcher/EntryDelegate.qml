import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import qs.modules.common

Button {
    id: root

    property DesktopEntry entry
    property color bg: "#DADADA"
    property color fg: "#232A2D"
    property real iconSize: 48
    property real radius: 12
    property real transparency: 1
    property real space: 8

    padding: 24

    contentItem: Item {
        implicitWidth: 100
        implicitHeight: 120
        FlexboxLayout {
            id: layout

            anchors.fill: parent

            direction: FlexboxLayout.Column
            justifyContent: FlexboxLayout.JustifySpaceEvenly
            alignItems: FlexboxLayout.AlignCenter
            gap: root.space

            IconImage {
                source: Quickshell.iconPath(root.entry.icon, "image-missing")
                implicitSize: root.iconSize
            }

            Text {
                font {
                    family: "JetBrainsMono Nerd Font"
                    pixelSize: 14
                }
                color: root.fg
                text: root.entry.name
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    background: Rectangle {
        anchors.fill: parent
        radius: 12
        color: Qt.alpha(root.bg, root.transparency)
    }
}
