pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import qs.utils.matugen

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
            property bool dark

            onDirectoryChanged: { 
                var mode = wallpaperJsonAdapter.dark ? "dark" : "light"
                Matugen.generate(Quickshell.env("HOME") + directory + filename, mode) 
                console.log("Theme changed")
            }
            onFilenameChanged: {
                var mode = wallpaperJsonAdapter.dark ? "dark" : "light"
                Matugen.generate(Quickshell.env("HOME") + directory + filename, mode) 
                console.log("Theme changed")
            }
            onDarkChanged: {
                var mode = wallpaperJsonAdapter.dark ? "dark" : "light"
                Matugen.generate(Quickshell.env("HOME") + directory + filename, mode) 
                console.log("Theme changed")
            }
        }
    }
}
