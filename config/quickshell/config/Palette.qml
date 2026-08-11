pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property alias everblush: everblushAdapter

    FileView {
        id: everblushFileView

        path: Quickshell.shellPath("config/theme/everblush.json")
		    watchChanges: true
		    onFileChanged: reload()
        onAdapterUpdated: writeAdapter()

        JsonAdapter {
            id: everblushAdapter

            property color background: "#141b1e"
            property color lighterBackground: "#232a2d"
            property color red: "#E57474"
            property color green: "#8CCF7E"
            property color yellow: "#E5C76B"
            property color blue: "#67B0E8"
            property color magenta: "#C47FD5"
            property color cyan: "#6CBFBF"
            property color lightGray: "#B3B9B8"
            property color white: "#DADADA"
        }
    }
}
