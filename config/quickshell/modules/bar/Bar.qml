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

        direction: FlexboxLayout.Row
        justifyContent: FlexboxLayout.JustifySpaceEvenly

        anchors {
            fill: parent
            top: parent.top
            bottom: parent.bottom
            topMargin: bar.extraHeight / 2
            bottomMargin: bar.extraHeight / 2
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
