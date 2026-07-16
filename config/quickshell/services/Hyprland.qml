pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland

Singleton {
    id: root

    property alias workspaces: workspaceList
    property alias clients: clientList

    ListModel {
        id: workspaceList
        dynamicRole: false
    }

    ListModel {
        id: clientList
        dynamicRole: false
    }

    Connections {
        target: Hyprland

        function onRawEvent(event) {
            let ignoredEvents = [ 
                "activewindow", "activewindowv2", "fullscreen", "activelayout",
                "openwindow", "closewindow", "kill", "layer",
                "submap", "changefloatingmode", "urgent", "screencast",
                "windowtitle", "group"
            ];
            if ignoredEvents.includes(event.name) {
                return;
            } else {
                updateWorkspaceList(event);
                updateClientList(event);
            }
        }
    }

    function updateWorkspaceList(event: HyprlandEvent): void {
        
    }

    function updateClientList(event: HyprlandEvent): void {
        
    }
}
