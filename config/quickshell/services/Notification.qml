pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications
import QtQuick
import QtQml

Singleton {
    id: root

    property bool dnd: false
    property string path: Quickshell.shellPath("storage/notifications.json")
    property real idOffset
    property int revision: 0
    function bump() { root.revision++ }

    property alias notifications: notifications
    property alias popups: popups
    property alias file: fileView
    property alias notificationWrapper: notificationWrapper
    property alias saveDebounce: saveDebounce

    ListModel {
        id: notifications
    }

    ListModel {
        id: popups
    }

    FileView {
        id: fileView

        path: root.path
		    watchChanges: true
        onLoaded: () => {
            let parsed = []
            try {
                parsed = JSON.parse(root.file.text())
            } catch (e) {
                console.log("[Notif] failed to parse history: ", e)
                return;
            }
            root.notifications.clear()
            const sorted = parsed.slice().sort((a, b) => b.time - a.time)

            let maxID = 0
            sorted.forEach((data) => {
                const wrapper = root.notificationWrapper.createObject(root, {
                    "notificationID": data.notificationID,
                    "notification": null,
                    "appIcon": data.appIcon,
                    "appName": data.appName,
                    "body": data.body,
                    "image": data.image,
                    "summary": data.summary,
                    "date": data.date,
                    "time": data.time,
                    "urgency": data.urgency,
                    "actions": data.actions ?? [],
                });
                root.notifications.append({ "wrapper": wrapper })
                maxID = Math.max(maxID, data.notificationID)
            })

            root.idOffset = maxID
        }
        onLoadFailed: (error) => { 
            if (error === FileViewError.FileNotFound) {
                console.log("[Notif] no history file found")
                root.notifications.clear();
                root.save(root.file, root.notifications)
            } else { console.log("[Notif] error: ", error) }
        }
    }

    component NotificationWrapper: QtObject {
        id: wrapper

        required property int notificationID
        property Notification notification: null
        property var actions: notification?.actions.map((action) => ({ "identifier": action?.identifier, "text": action?.text }))
        property bool popup: false
        property string appIcon: notification?.appIcon ?? ""
        property string appName: notification?.appName ?? ""
        property string body: notification?.body ?? ""
        property string image: notification?.image ?? ""
        property string summary: notification?.summary ?? ""
        property double expiresAt: 0
        property string date
        property double time 
        property string urgency: notification?.urgency.toString() ?? "normal"
    }

    Component {
        id: notificationWrapper
        NotificationWrapper {}
    }

    NotificationServer {
        id: server

        inlineReplySupported: true
        bodyImagesSupported: true
        bodyMarkupSupported: true
        actionsSupported: true
        actionIconsSupported: true
        bodyHyperlinksSupported: true
        imageSupported: true
        persistenceSupported: true

        onNotification: (notification) => {
            notification.tracked = true
        }
    }

    Connections {
        target: server.trackedNotifications

        function onObjectInsertedPost(n, _) {
            root.insert(n, root.notifications)
            if (!root.dnd) { root.insert(n, root.popups) }
        }

        function onObjectRemovedPost(n, _) {
            root.remove(n, root.notifications)
            if (!root.dnd) { root.remove(n, root.popups) }
        }
    }

    function idFor(notification) { return notification.id + root.idOffset }

    function indexForId(id, listModel) {
        for (let i = 0; i < listModel.count; i++) {
            if (listModel.get(i).wrapper.notificationID === id) return i
        }
        return -1
    }

    function insert(notification, listModel) {
        const wrapper = root.notificationWrapper.createObject(root, {
            "notificationID": root.idFor(notification),
            "notification": notification,
            "time": Date.now(),
        })        

        wrapper.date = new Date(wrapper.time).toDateString()
        wrapper.popup = !root.dnd

        if (wrapper.popup) {
            const timeout = notification.expireTimeout >= 0 ? notification.expireTimeout : 5000
            wrapper.expiresAt = wrapper.time + timeout
        }

        listModel.insert(0, { "wrapper": wrapper })
        root.saveDebounce.restart()
    } 

    function remove(notification, listModel) {
        const index = root.indexForId(root.idFor(notification), listModel)
        if (index !== -1) {
            const wrapper = listModel.get(index).wrapper
            listModel.remove(index)
            wrapper.destroy()
        }
        root.saveDebounce.restart()
    }

    function discard(id) {
        const notif = server.trackedNotifications.values.find((n) => root.idFor(n) === id)
        if (notif) {
            notif.dismiss()
            return
        }
        const index = root.indexForId(id, root.notifications)
        if (index !== -1) {
            const wrapper = notifications.get(index).wrapper
            root.notifications.remove(index)
            wrapper.destroy()
            root.saveDebounce.restart()
            root.bump()
        }
    }

    function activate(id) {
        const notif = server.trackedNotifications.values.find((n) => root.idFor(n) === id)
        if (!notif) {
            console.log("[Notif] activate: notification not tracked: " + id)
            return
        }
        const defaultAction = notif.actions.find((a) => a.identifier === "default") ?? notif.actions[0]
        if (defaultAction) {
            defaultAction.invoke()
        }
        root.discard(id)
    }

    function save(file, listModel) {
        let array = [];
        for (let i = 0; i < listModel.count; i++) {
            const wrapper = listModel.get(i).wrapper
            array.push({
                "notificationID": wrapper.notificationID,
                "appIcon": wrapper.appIcon,
                "appName": wrapper.appName,
                "body": wrapper.body,
                "image": wrapper.image,
                "summary": wrapper.summary,
                "date": wrapper.date,
                "time": wrapper.time,
                "urgency": wrapper.urgency,
            })
        }
        file.setText(JSON.stringify(array, null, 2))
    }

    Timer {
        id: saveDebounce
        interval: 100
        onTriggered: root.save(file, notifications)
    }
}
