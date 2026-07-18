import QtQuick

Text {
    id: root

    property real pixelSize: 14
    property string fontFamily: "JetbrainsMono Nerd Font"
    property string reservedChars
    readonly property alias tm: tm

    font: {
        family: root.fontFamily
        pixelSize: root.pixelSize
    }

    color: "#DADADA"
    horizontalAlignment: Text.AlignHCenter

    TextMetrics {
        id: tm
        font: root.fontFamily
        text: root.reservedChars
    }
}
