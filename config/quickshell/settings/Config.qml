import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property color background: "#141b1e"
    readonly property color lighterBackground: "#232a2d"
    readonly property color red: "#E57474"
    readonly property color green: "#8CCF7E"
    readonly property color yellow: "#E5C76B"
    readonly property color blue: "#67B0E8"
    readonly property color magenta: "#C47FD5"
    readonly property color cyan: "#6CBFBF"
    readonly property color lightGray: "#B3B9B8"
    readonly property color white: "#DADADA"

    readonly property real iconSize: 48
    readonly property real fontSize: 16
    readonly property string fontFamily: "JetBrainsMono Nerd Font"
}
