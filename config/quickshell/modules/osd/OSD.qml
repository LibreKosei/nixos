import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.services
import qs.settings
import qs.modules.common

PanelWindow {
    id: root

    property real minValue: 1
    property real maxValue: 150
    property real value
    property real radius: 12
    property color fg: Config.white
    property color bg: Qt.alpha(Config.lighterBackground, 0.85)
    property color iconColor: Config.white
    property real iconSize: 32
    property string iconName
    property string handlerIconName
    
    anchors {
        bottom: true
    }

    mask: Region {}
    color: "transparent"
    WlrLayershell.layer: WlrLayer.Overlay
    exclusionMode: ExclusionMode.Ignore

    implicitWidth: 100
    implicitHeight: 100

    margins.bottom: 60

    Rectangle {
        anchors.fill: parent
        radius: root.radius
        color: root.bg
        border.width: 2
        border.color: Config.yellow

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10

            Icon {
                Layout.alignment: Qt.AlignHCenter
                iconName: root.iconName
                iconColor: root.iconColor
                implicitSize: root.iconSize
            }

            Text {
                font {
                    family: "JetBrainsMono Nerd Font"
                    pixelSize: 14
                }
                color: Config.magenta
                text: Audio.sink.nickname
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
                Layout.alignment: Qt.AlignCenter
            }

            Text {
                font {
                    family: "JetBrainsMono Nerd Font"
                    pixelSize: 14
                }
                color: Config.blue
                text: `${Audio.dsVol}%`
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
                Layout.alignment: Qt.AlignCenter
            }
        }
    }
}
