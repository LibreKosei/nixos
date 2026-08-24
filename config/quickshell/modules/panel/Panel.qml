import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.config

PopupWindow {
    id: root

    implicitWidth: background.implicitWidth + shadow.offset.x * 2
    implicitHeight: background.implicitHeight + shadow.offset.y * 2
    color: "transparent"
    visible: States.showQS

    RectangularShadow {
        id: shadow
        visible: true
        anchors.fill: background
        offset.x: 4
        offset.y: 8
        radius: background.radius
        color: Colors.md3.shadow
    }

    Rectangle {
        id: background

        implicitWidth: 450
        implicitHeight: 500
        color: Colors.md3.background
        radius: General.radius.large

        ColumnLayout {
            id: columnLayout

            anchors.fill: parent
            // anchors.margins: General.margin.large
            //
            Header {
                Layout.alignment: Qt.AlignTop
                Layout.fillWidth: true
            }

            Footer {
                Layout.alignment: Qt.AlignBottom
                Layout.fillWidth: true
            }
        }
    }
}
