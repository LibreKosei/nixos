import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.config

PanelWindow {
    id: root

    implicitWidth: 500
    implicitHeight: 600
    color: Colors.md3.surface_container
    visible: States.showQS
    WlrLayershell.layer: WlrLayer.Overlay

    anchors {
        bottom: true
        right: true
    }


}
