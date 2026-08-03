pragma Singleton
import Quickshell
import Quickshell.WindowManager
import QtQuick
import QtQml.Models

Singleton {
    id: root

    ListModel {
        id: workspaces
    }

    property alias workspaces: workspaces

    readonly property var currentWs: [...WindowManager.windowsets].find(ws => ws.active)
    readonly property var urgentWs: [...WindowManager.windowsets].find(ws => ws.urgent)
    // Sorts the workspace by `name` in ascending order. This behavior might be unstable
    readonly property list<Windowset> visibleWss: [...WindowManager.windowsets]
      .sort((a, b) => a.name.localeCompare(b.name))
      .filter((w) => w.shouldDisplay && w.name !== "10")

    onVisibleWssChanged: () => {
        const wss = root.visibleWss
        const removed = getRemoved(wss)
        const inserted = getNew(wss)
        removed.forEach(x => deleteWs(x, root.workspaces))
        inserted.forEach(x => insertWs(x, root.workspaces))
        reorderWss(wss)
        // console.log("[Workspace] workspace amount: ", root.workspaces.count)
    }

    function containWs(workspace, listModel) {
        for (let i = 0; i < listModel.count; i++) {
            if (workspace === listModel.get(i).workspace) return true
        }
        return false
    }

    function getRemoved(list) {
        let wsList = []
        for (let i = 0; i < root.workspaces.count; i++) wsList.push(root.workspaces.get(i).workspace)
        const different = wsList.filter(x => !list.includes(x))
        return different
    }

    function getNew(list) {
        let wsList = []
        for (let i = 0; i < root.workspaces.count; i++) wsList.push(root.workspaces.get(i).workspace)
        return list.filter(x => !wsList.includes(x))
    }

    function insertWs(workspace, listModel) {
        if (containWs(workspace, listModel)) { return } 
        listModel.append({ workspace: workspace })
        // console.log("[Workspace] inserted a workspace")
    }

    function deleteWs(workspace, listModel) {
        for (let i = 0; i < listModel.count; i++) {
            if (workspace === listModel.get(i).workspace) {
                listModel.remove(i)
            }
        }
        return
    }

    function reorderWss(sorted) {
        for (let i = 0; i < sorted.length; i++) {
            const target = sorted[i]
            let currentIndex = -1
            for (let j = i; j < root.workspaces.count; j++) {
                if (root.workspaces.get(j).workspace === target) {
                    currentIndex = j
                    break
                }
            }
            if (currentIndex !== -1 && currentIndex !== i) {
                root.workspaces.move(currentIndex, i, 1)
            }
        }
    }

}
