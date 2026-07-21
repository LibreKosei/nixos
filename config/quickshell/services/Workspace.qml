pragma Singleton
import Quickshell
import Quickshell.WindowManager
import QtQuick

Singleton {
    id: root

    readonly property var currentWs: [...WindowManager.windowsets].find(ws => ws.active)
    readonly property var urgentWs: [...WindowManager.windowsets].find(ws => ws.urgent)
    // Sorts the workspace by `name` in ascending order. This behavior might be unstable
    readonly property list<Windowset> visibleWss: [...WindowManager.windowsets]
      .sort((a, b) => a.name - b.name)
      .filter((w) => w.shouldDisplay)
}
