import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

// qmllint disable uncreatable-type
PanelWindow {
    // qmllint enable
    id: bar

    property real extraHeight: 20
    implicitWidth: screen.width
    implicitHeight: flexLayout.implicitHeight + extraHeight
    color: "#141b1e"

    anchors {
        left: true
        right: true
        bottom: true 
    }

    WlrLayershell.layer: WlrLayer.Top

    FlexboxLayout {
        id: flexLayout

        anchors {
            top: parent.top
            bottom: parent.bottom
            topMargin: bar.extraHeight / 2
            bottomMargin: bar.extraHeight / 2
        }

        IconButton {
            id: example
            paddingSize: 12
            iconSize: 24
            borderSize: 1.5
            borderColor: "transparent"
            iconColor: "#DADADA"
            iconName: "network-wireless-signal-good-symbolic"
        }
    }
}
