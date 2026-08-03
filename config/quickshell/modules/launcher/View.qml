import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import qs.services

Item {
    id: root

    property alias model: repeater.model
    property int currentIndex: 0

    property real cardSpacing: 90     // horizontal gap between adjacent cards
    property real maxRotation: 18     // degrees, outermost visible cards
    property real minScale: 0.75
    property real maxScale: 1.15      // selected card
    property real yArc: 40            // vertical drop per step away from center
    property int visibleRange: 4      // cards shown on each side before fading out

    implicitHeight: 260

    Repeater {
        id: repeater

        delegate: EntryDelegate {
            id: card
            required property DesktopEntry modelData
            required property int index
            entry: modelData

            readonly property int offset: index - root.currentIndex
            readonly property real absOffset: Math.abs(offset)
            readonly property bool isCurrent: offset === 0

            visible: absOffset <= root.visibleRange
            z: 100 - absOffset

            anchors.verticalCenter: parent.verticalCenter
            x: parent.width / 2 - width / 2 + offset * root.cardSpacing
            y: parent.height / 2 - height / 2
               + Math.min(absOffset, root.visibleRange) * root.yArc

            scale: isCurrent
                   ? root.maxScale
                   : Math.max(root.minScale, root.maxScale - absOffset * 0.12)

            rotation: Math.max(-root.maxRotation,
                      Math.min(root.maxRotation, offset * 6))

            opacity: absOffset <= root.visibleRange
                     ? 1.0 - (absOffset / (root.visibleRange + 1)) * 0.6
                     : 0.0

            transformOrigin: Item.Bottom

            Behavior on x { NumberAnimation { duration: 220; easing.type: Easing.OutCubic } }
            Behavior on y { NumberAnimation { duration: 220; easing.type: Easing.OutCubic } }
            Behavior on scale { NumberAnimation { duration: 220; easing.type: Easing.OutCubic } }
            Behavior on rotation { NumberAnimation { duration: 220; easing.type: Easing.OutCubic } }
            Behavior on opacity { NumberAnimation { duration: 180 } }
        }
    }
}
