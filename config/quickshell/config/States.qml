pragma Singleton

import Quickshell
import QtQuick

PersistentProperties {
    id: persistentProps

    reloadableId: "persistentStates"

    property bool showBar: true
    property bool showLauncher: false
    property bool locked: false
    property bool showQS: false
}
