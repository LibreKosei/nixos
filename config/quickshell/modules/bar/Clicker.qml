import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import qs.config
import qs.modules.common

Item {
    id: root

    default property alias content: layout.data
    property bool shadowEnabled: false
    property var direction: FlexboxLayout.Row
    property color backgroundColor: Colors.md3.primary_container

    implicitHeight: 48
    implicitWidth: layout.implicitWidth + General.margin.medium * 2

    HoverHandler {
        cursorShape: Qt.PointingHandCursor
    }

    Shadow {
        id: shadow

        visible: root.shadowEnabled
        anchors.fill: background
        radius: background.radius
    }

    Rectangle {
        id: background

        anchors.fill: parent
        color: root.backgroundColor
        radius: General.radius.medium
    }

    FlexboxLayout {
        id: layout
        
        anchors.centerIn: parent
        gap: General.spacing.medium
        justifyContent: FlexboxLayout.JustifySpaceBetween
        alignItems: FlexboxLayout.AlignCenter
    }
}
