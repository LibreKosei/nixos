pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    property alias props: persistentProps
        
    PersistentProperties {
        id: persistentProps

        reloadableId: "persistentStates"

        property bool showBar: true
        property bool showLauncher: false
        property bool locked: false
    }
}
