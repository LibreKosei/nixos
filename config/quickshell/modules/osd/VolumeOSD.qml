import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.services
import qs.modules.common

Scope {
    id: root

    property bool showOSD: false
    
    Connections {
        target: Audio.sink.audio
        function onVolumeChanged() {
            root.showOSD = true
            hideTimer.restart()
        }
    }

    Timer {
        id: hideTimer
        interval: 1000
        onTriggered: root.showOSD = false
    }

    LazyLoader {
        activeAsync: root.showOSD
        
        OSD {
            value: Audio.dsVol
            iconName: Audio.getIconName(Audio.sink)
        }
    }
}
