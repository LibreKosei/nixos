import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

// qmllint disable uncreatable-type
PanelWindow {
    // qmllint enable
    id: bar

    implicitWidth: screen.width
    implicitHeight: 60
    color: "transparent"

    anchors {
        left: true
        right: true
        bottom: true 
    }

    WlrLayershell.layer: WlrLayer.Top

    FlexboxLayout {
        id: flexLayout

        direction: FlexboxLayout.Row
        justifyContent: FlexboxLayout.JustifySpaceEvenly
        alignItems: FlexboxLayout.AlignCenter
        alignContent: FlexboxLayout.AlignCenter

        anchors {
            fill: parent
        }

        Group {
            id: example
            padding: 12
            iconSize: 24
            iconColor: "#DADADA"
            iconName: "network-wireless-signal-good-symbolic"
        }
    }
}
