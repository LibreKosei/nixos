import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Effects
import QtQuick.Controls
import QtQuick.Layouts
import qs.services
import qs.settings
import qs.config

PanelWindow {
    id: root

    implicitWidth: 800 + shadow.offset.x * 2
    implicitHeight: 800 + shadow.offset.y * 2
    color: "transparent"
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
    visible: States.showLauncher

    onVisibleChanged: if (visible) searchField.forceActiveFocus()

    WlrLayershell.layer: WlrLayer.Overlay

    RectangularShadow {
        id: shadow
        visible: true
        anchors.fill: bg
        offset.x: 4
        offset.y: 8
        radius: bg.radius
        color: Qt.alpha(Colors.md3.shadow, 0.7)
    }
    Rectangle {
        id: bg
        implicitHeight: 800
        implicitWidth: 800
        color: Qt.alpha(Colors.md3.surface, 0.7)
        radius: General.radius.xl

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: General.margin.xl

            SearchBar {
                id: searchField

                Layout.preferredWidth: 200
                Layout.preferredHeight: 50
                Layout.alignment: Qt.AlignHCenter

                Keys.onPressed: (event) => {
                    switch (event.key) {
                    case Qt.Key_Escape:
                        States.showLauncher = false
                        event.accepted = true
                        break
                    case Qt.Key_Down:
                        view.moveCurrentIndexDown()
                        event.accepted = true
                        break
                    case Qt.Key_Up:
                        view.moveCurrentIndexUp()
                        event.accepted = true
                        break
                    case Qt.Key_Right:
                        view.moveCurrentIndexRight()
                        event.accepted = true
                        break
                    case Qt.Key_Left:
                        view.moveCurrentIndexLeft()
                        event.accepted = true
                        break
                    default:
                        break
                    }
                }
                //
                onAccepted: {
                    if (view.currentIndex < 0 || view.currentIndex >= Apps.sortedEntries.count)
                        return

                    const entry = Apps.sortedEntries.get(view.currentIndex).entry
                    Apps.launch(entry, false)
                    States.showLauncher = false
                }
            }

            // EntryView {
            //     id: view
            //     Layout.alignment: Qt.AlignHCenter
            //     Layout.fillHeight: true
            //     Layout.preferredWidth: Math.min(this.contentWidth, parent.width)
            //     onCurrentIndexChanged: {
            //         positionViewAtIndex(currentIndex, ListView.Contain)
            //     }
            // }
            View {
                id: view

                Layout.alignment: Qt.AlignHCenter
                Layout.fillHeight: true
            }
        }
    }
}
