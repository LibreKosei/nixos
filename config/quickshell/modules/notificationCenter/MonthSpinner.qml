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
                    let d = new Date(root.monthGrid.year, root.monthGrid.month - 1, 1)  
                    root.monthGrid.year = d.getFullYear()
                    root.monthGrid.month = d.getMonth()
                }
            }
        }

        MonoText {
            id: monthLabel
            
            text: Qt.locale().monthName(root.monthGrid.month).substring(0, 3)
            color: Colors.md3.on_surface
        }

        Icon {
            id: nextIcon

            iconName: "go-next-symbolic"
            iconColor: Colors.md3.on_surface
            implicitSize: 16

            TapHandler {
                onTapped: () => {
                    let d = new Date(root.monthGrid.year, root.monthGrid.month + 1, 1)  
                    root.monthGrid.year = d.getFullYear()
                    root.monthGrid.month = d.getMonth()
                }
            }
        }
    }
}
