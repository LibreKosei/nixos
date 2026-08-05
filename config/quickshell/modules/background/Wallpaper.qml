import QtQuick
import Quickshell
import qs.config

Item {
    id: root

    property string source: Quickshell.env("HOME") + Misc.wallpaper.directory + Misc.wallpaper.filename
    property bool setWallpaper: true
    property color backgroundColor: "#141B1E"

    Image {
        id: wallpaper

        visible: root.setWallpaper
        anchors.fill: parent
        asynchronous: true
        source: root.source
        cache: true
        Component.onCompleted: console.log("Background loaded: ", visible)
    }

    Rectangle {
        id: background

        /*
         * This rectangle is for single color background.
         * Only visible when `setWallpaper` is false
        */
        anchors.fill: parent
        visible: !(root.setWallpaper)
        color: root.backgroundColor 
    }
}
