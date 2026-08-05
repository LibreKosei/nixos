pragma Singleton
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick
import QtQml
import qs.settings

// All timers start at the same time, not sequentially
Singleton {
    id: root

    property bool active: idleMonitor.isIdle
    property real fstInterval: 150
    property real sndInterval: 210
    property real lockInterval: 300

    function lock() { 
        // console.log("Locking screen...") 
        Config.persistent.locked = true
    }

    function dim() { 
        Brightness.decrease(10) 
    }

    onActiveChanged: (state) => {
        // console.log("[Idle Monitor] current state: ", root.active)
        if (root.active) {
            Brightness.save()
            dimTimer.start()
            dimTimer2.start()
            lockTimer.start()
        } else {
            dimTimer.stop()
            dimTimer2.stop()
            lockTimer.stop()
            Brightness.restore()
        }
    }

    Timer {
        id: dimTimer
        interval: root.fstInterval * 1000
        onTriggered: if (!Config.persistent.locked) root.dim()
    }

    Timer {
        id: dimTimer2
        interval: root.sndInterval * 1000
        onTriggered: if (!Config.persistent.locked) root.dim()
    }

    Timer {
        id: lockTimer
        interval: root.lockInterval * 1000
        onTriggered: if (!Config.persistent.locked) root.lock()
    }

    IdleMonitor {
        id: idleMonitor
        enabled: true
        timeout: 10
    }

    // Component.onCompleted: console.log("[Idle daemon] active: ", root.isActive)
}
