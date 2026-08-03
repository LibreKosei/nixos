import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.services
import qs.settings

PanelWindow {
    id: root

    implicitWidth: screen.width
    implicitHeight: 500
    color: Qt.alpha("#141B1E", 0)
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
    visible: Config.persistent.showLauncher

    onVisibleChanged: if (visible) searchField.forceActiveFocus()

    anchors {
        right: true
        left: true
    }

    WlrLayershell.layer: WlrLayer.Overlay

    ColumnLayout {
        anchors.fill: parent
        anchors.rightMargin: 200
        anchors.leftMargin: 200

        TextField {
            id: searchField

            Layout.preferredWidth: 200
            Layout.preferredHeight: 50
            Layout.alignment: Qt.AlignHCenter
            placeholderText: qsTr("Search app...")
            placeholderTextColor: "#DADADA"
            focus: true

            text: Apps.text
            onTextEdited: Apps.text = text
            color: "#DADADA"

            background: Item {
                anchors.fill: parent

                Rectangle {
                    anchors.fill: parent
                    radius: 8
                    color: "#232A2D"
                    border.width: 2
                    border.color: "#DADADA"
                }
            }

            Keys.onPressed: (event) => {
                switch (event.key) {
                case Qt.Key_Escape:
                    Config.persistent.showLauncher = false
                    event.accepted = true
                    break
                case Qt.Key_Down:
                    entryView.incrementCurrentIndex()
                    event.accepted = true
                    break
                case Qt.Key_Up:
                    entryView.decrementCurrentIndex()
                    event.accepted = true
                    break
                default:
                    break
                }
            }

            onAccepted: {
                if (entryView.currentIndex < 0 || entryView.currentIndex >= Apps.sortedEntries.count)
                    return

                const entry = Apps.sortedEntries.get(entryView.currentIndex).entry
                Apps.launch(entry)
                Config.persistent.showLauncher = false
            }
        }

        EntryView {
            id: entryView
            Layout.alignment: Qt.AlignHCenter
            Layout.fillHeight: true
            Layout.preferredWidth: Math.min(this.contentWidth, parent.width)
            onCurrentIndexChanged: {
                positionViewAtIndex(currentIndex, ListView.Contain)
            }
        }
    }
}
