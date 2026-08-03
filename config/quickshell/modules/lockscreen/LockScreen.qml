import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs.services
import qs.settings

Scope {
    id: root

    LockContext {
        id: lockContext

        onUnlocked: {
            Config.persistent.locked = false
            Brightness.restore()
        }
    }

    WlSessionLock {
        id: lock

        locked: Config.persistent.locked

        onLockedChanged: if (!locked) Config.persistent.locked = false

        WlSessionLockSurface {
            Surface {
                anchors.fill: parent
                context: lockContext
            }
        }
    }
}
