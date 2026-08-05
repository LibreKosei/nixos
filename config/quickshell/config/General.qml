pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property alias padding: jsonAdapter.padding
    property alias spacing: jsonAdapter.spacing
    property alias radius: jsonAdapter.radius
    property alias margin: jsonAdapter.margin

    FileView {
        id: fileView

        path: Qt.resolvedUrl(Quickshell.shellPath("config/general/general.json"))
		    watchChanges: true
		    onFileChanged: reload()
        onAdapterUpdated: writeAdapter()

        JsonAdapter {
            id: jsonAdapter

            property Adapter padding: Adapter {}
            property Adapter spacing: Adapter {}
            property Adapter radius : Adapter {}
            property Adapter margin: Adapter {}
        }
    }

    component Adapter: JsonObject {
        property real small
        property real medium
        property real large
        property real xl
    }
}
