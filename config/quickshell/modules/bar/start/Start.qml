import QtQuick
import QtQuick.Layouts
import qs.settings

FlexboxLayout {
    id: root

    alignItems: FlexboxLayout.AlignStart
    alignContent: FlexboxLayout.AlignCenter
    gap: Config.spacing.medium

    Launcher {}

    Workspace {
        Layout.fillWidth: true
        Layout.fillHeight: true
    }
}
