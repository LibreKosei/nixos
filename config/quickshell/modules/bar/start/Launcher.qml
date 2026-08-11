import QtQuick
import qs.config
import qs.settings
import qs.modules.common

Clickable {
    id: root

    bgColor: Colors.md3.tertiary_container
    radius: 0
    elevation: 0

    Icon {
        id: icon
        iconName: "view-app-grid-symbolic"
        iconColor: Colors.md3.on_tertiary_container
    }

    onClicked: () => { Config.persistent.showLauncher = !(Config.persistent.showLauncher) }

    Component.onCompleted: console.log("Launcher Icon: height", implicitHeight)
}
