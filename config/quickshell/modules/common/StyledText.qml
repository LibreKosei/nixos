import QtQuick

Item {
    id: root

    property real pixelSize: 14
    property string fontFamily: "JetBrainsMono Nerd Font"
    property string reservedChars
    property string text
    property alias tm: tm

    implicitWidth: txt.implicitWidth
    implicitHeight: txt.implicitHeight
    
    TextMetrics {
        id: tm
        font {
            family: root.fontFamily
            pixelSize: root.pixelSize
        }
        text: root.reservedChars
    }

    Text {
        id: txt
        font {
            family: root.fontFamily
            pixelSize: root.pixelSize
        }

        text: root.text
        color: "#DADADA"
        horizontalAlignment: Text.AlignHCenter
        width: tm.width
    }
}
