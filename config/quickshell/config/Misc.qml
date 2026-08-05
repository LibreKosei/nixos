pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property alias wallpaper: wallpaperJsonAdapter

    FileView {
        id: wallpaperFileView

        path: Quickshell.shellPath("config/misc/wallpaper.json")
		    watchChanges: true
		    onFileChanged: reload()
        onAdapterUpdated: writeAdapter()

        JsonAdapter {
            id: wallpaperJsonAdapter

            property string directory
            property string filename
        }
    }
}
