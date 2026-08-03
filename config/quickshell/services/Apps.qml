pragma Singleton
import QtQuick
import QtQml.Models
import Quickshell
import "../utils/fuzzysort.js" as Fuzzy

Singleton {
    id: root

    ListModel {
        id: entries
        onCountChanged: root.updateResults()
    }

    ListModel {
        id: results
    }

    property alias entries: entries
    property alias sortedEntries: results
    property string text: ""

    function launch(entry, withUWSM = true) {
        if (withUWSM) {
            Quickshell.execDetached([ "uwsm", "app", "--", ...entry.command ])
        } else { entry.execute() }
    } 

    onTextChanged: updateResults()

    function updateResults() {
        results.clear()

        let targets = []
        for (let i = 0; i < entries.count; i++) {
            targets.push(entries.get(i).entry)
        }

        if (!text || text.length === 0) {
            targets.forEach(t => results.append({ entry: t }))
            return
        }

        const matches = Fuzzy.go(text, targets, {
            keys: ["name", "genericName", "comment", "keywords"],
            limit: 10,
        }).sort((a, b) => a.obj.name.localeCompare(b.obj.name))
        matches.forEach(m => results.append({ entry: m.obj }))
    }

    readonly property list<DesktopEntry> allApps: 
        [...DesktopEntries.applications.values].sort((a, b) => a.name.localeCompare(b.name))
        .filter(a => !a.runInTerminal && !a.noDisplay)

    onAllAppsChanged: () => {
        const apps = root.allApps
        const appList = []
        for (let i = 0; i < root.entries.count; i++) { appList.push(root.entries.get(i).entry) }
        const removed = getRemoved(apps, appList)
        const inserted = getNew(apps, appList)
        removed.forEach(entry => removeEntry(entry, root.entries))
        inserted.forEach(entry => insertEntry(entry, root.entries))
    } 

    function getRemoved(apps, appList) {
        const differences = appList.filter(x => !apps.includes(x))
        return differences
    }

    function getNew(apps, appList) {
        const differences = apps.filter(x => !appList.includes(x))
        return differences
    }

    function containsEntry(entry, listModel) {
        let i = 0
        for (i; i < listModel.count; i++) {
            if (listModel.get(i).entry === entry) return true
        }
        return false
    }

    function insertEntry(entry, listModel) {
        if (containsEntry(entry, listModel)) return
        listModel.append({ entry: entry })
    }

    function removeEntry(entry, listModel) {
        if (containsEntry(entry, listModel)) {
            let i = 0
            for (i; i < listModel.count; i++) {
                if (entry === listModel.get(i).entry) { 
                    listModel.remove(i) 
                    break
                }
            }
        }
    }

    Component.onCompleted: { 
        console.log("[Desktop Entries] amount: ", root.entries.count) 
        console.log("[Desktop Entries] sorted apps amount: ", root.sortedEntries.count)
    }
}
