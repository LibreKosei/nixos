import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pipewire
import qs.services
import qs.modules.common
import qs.settings
import qs.modules.bar.start
import qs.modules.bar.center
import qs.modules.bar.end

// qmllint disable uncreatable-type
PanelWindow {
    // qmllint enable
    id: bar

    implicitWidth: screen.width
    implicitHeight: 60
    color: Qt.alpha("#141B1E", 0.3)
    WlrLayershell.layer: WlrLayer.Overlay

    anchors {
        bottom: true 
    }

    Item {
        anchors {
            fill: parent
        }
        Start {
            id: leftGroup
            anchors.left: parent.left
            anchors.leftMargin: 100
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: center.left // optional, prevents overlap on small screens
        }

        Center {
            id: center
            anchors.centerIn: parent
        }

        End {
            id: rightGroup

            anchors.right: parent.right
            anchors.rightMargin: 100
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
