import QtQuick
import qs.settings
import qs.modules.common

Clickable {
    id: root

    Icon {
        id: icon
        iconName: "view-app-grid-symbolic"
        iconColor: Config.yellow
    }

    onClicked: () => { Config.persistent.showLauncher = !(Config.persistent.showLauncher) }
}
