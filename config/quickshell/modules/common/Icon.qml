import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets

IconImage {
    id: root

    property string iconName: "image-missing-symbolic"
    property bool isSymbolic: true
    property color iconColor: "#DADADA"

    source: Quickshell.iconPath(iconName, "image-missing-symbolic")
    implicitSize: 24

    layer.enabled: true
    layer.effect: MultiEffect {
        source: root
        colorization: 1.0
        colorizationColor: root.iconColor
        brightness: isSymbolic ? 0.7 : 0
    }
}
