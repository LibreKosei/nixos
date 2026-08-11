import QtQuick
import QtQuick.Layouts
import qs.settings
import qs.config
import qs.modules.common
import qs.modules.bar

FlexboxLayout {
    id: root

    alignItems: FlexboxLayout.AlignCenter
    alignContent: FlexboxLayout.AlignCenter
    gap: Config.spacing.medium

    Clicker {
        id: launcherIcon
        
        Icon {
            iconName: "view-app-grid-symbolic"
            iconColor: Colors.md3.primary
        }

        TapHandler {
            onTapped: States.showLauncher = !(States.showLauncher)
        }
    }

    Workspaces {
        // Layout.fillWidth: true
        // Layout.fillHeight: true
    }
}
