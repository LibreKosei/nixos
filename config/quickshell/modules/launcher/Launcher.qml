import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.services
import qs.settings
import qs.config

PanelWindow {
    id: root

    implicitWidth: 800
    implicitHeight: 800
    color: "#80000000"
    BackgroundEffect.blurRegion: Region { item: root.contentItem }
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
    visible: Config.persistent.showLauncher

    onVisibleChanged: if (visible) searchField.forceActiveFocus()

    WlrLayershell.layer: WlrLayer.Overlay

    Rectangle {
        id: bg
        anchors.fill: parent
        color: "transparent"
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
                        Config.persistent.showLauncher = false
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
                    Config.persistent.showLauncher = false
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
