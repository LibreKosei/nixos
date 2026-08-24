import QtQuick
import QtQuick.Layouts
import qs.config
import qs.modules.common

Item {
    id: root

    property bool active: true
    property bool hasAction: false
    property string iconName: "image-missing-symbolic"
    property real iconSize: 24
    property color iconColor: root.active ? Colors.md3.on_primary : Colors.md3.on_surface
    property real iconBrightness: 0.7
    property var onClicked

    implicitHeight: 75
    implicitWidth: 150

    TapHandler {
        onTapped: onClicked
    }

    Rectangle {
        id: background
        
        anchors.fill: parent
        color: root.active ? Colors.md3.primary : Colors.md3.surface_container
        radius: General.radius.small
    }
    
    RowLayout {
        id: rowLayout
        anchors.fill: parent

        Item {
            id: mainIconSlot

            Layout.fillWidth: true
            Layout.fillHeight: true

            Icon {
                id: mainIcon

                anchors.centerIn: parent
                iconName: root.iconName
                iconColor: root.iconColor
                brightness: root.iconBrightness
            }
        }

        Rectangle {
            id: separator

            visible: root.hasAction
            Layout.preferredWidth: 1
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignCenter
            color: Colors.md3.outline
        }

        Item {
            id: arrowIconSlot

            visible: root.hasAction
            Layout.fillWidth: root.hasAction
            Layout.preferredWidth: root.hasAction ? -1 : 0
            Layout.fillHeight: true

            Icon {
                id: arrowIcon
                anchors.centerIn: parent

                iconColor: root.active ? Colors.md3.on_primary : Colors.md3.on_surface
                iconName: "go-next-symbolic"
            }
        }
    }
}
