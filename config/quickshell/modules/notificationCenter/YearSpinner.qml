import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import qs.settings
import qs.config
import qs.services
import qs.modules.common

Item {
    id: root

    implicitWidth: 150
    implicitHeight: 50

    property var monthGrid

    Rectangle {
        id: background

        anchors.fill: parent
        color: "transparent"
        radius: General.radius.small
    }

    FlexboxLayout {
        id: flexboxLayout

        anchors.fill: parent
        justifyContent: FlexboxLayout.JustifySpaceBetween
        alignItems: FlexboxLayout.AlignCenter

        Icon {
            id: prevIcon

            iconName: "go-previous-symbolic"
            iconColor: Colors.md3.on_surface
            implicitSize: 16

            TapHandler {
                onTapped: () => {
                    root.monthGrid.year -= 1
                }
            }
        }

        MonoText {
            id: monthLabel
            
            text: `${root.monthGrid.year}`
            color: Colors.md3.on_surface
        }

        Icon {
            id: nextIcon

            iconName: "go-next-symbolic"
            iconColor: Colors.md3.on_surface
            implicitSize: 16

            TapHandler {
                onTapped: () => {
                    root.monthGrid.year += 1
                }
            }
        }
    }
}
