import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.settings

// qmllint disable uncreatable-type
PanelWindow {
    id: root

    required property real barOffset

    implicitWidth: screen.width
    implicitHeight: screen.height - barOffset

    // qmllint disable unqualified unresolved-type
    margins {
        top: root.barOffset
    }

    anchors {
        top: true
        left: true
        right: true
    }

    // mask: Wallpaper {}

    WlrLayershell.layer: WlrLayer.Background
    aboveWindows: false

    Item {
        id: wallpaper

        anchors {
            fill: parent
        }

        // TODO! Replace with real wallpaper
        // Rectangle as the Wallpaper
        Rectangle {
            id: coloredRect
            anchors.fill: parent
            color: "#232a2d"
        }
    }
}
