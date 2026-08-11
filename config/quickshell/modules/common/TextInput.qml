import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.config

TextField {
    id: root
    
    property color bgColor: Colors.md3.surface_container
    placeholderTextColor: Colors.md3.on_surface_variant
    focus: true
    color: Colors.md3.on_surface
    horizontalAlignment: TextInput.AlignHCenter

    background: Item {
        anchors.fill: parent

        Rectangle {
            anchors.fill: parent
            radius: General.radius.small
            color: root.bgColor
            border.width: 2
            border.color: Colors.md3.outline_variant
        }
    }
}
