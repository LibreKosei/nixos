import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland
import qs.services
import qs.config
import qs.modules.common
import qs.settings
import qs.modules.bar.end

Rectangle {
	id: root
	required property LockContext context

	color: Config.background

	// Clickable {
	//      bgColor: Config.lighterBackground
	//      MonoText {
	//          id: emergencyText
	//          text: "It ain't working"
	//          color: Config.white
	//      }
	// 	  onClicked: context.unlocked();
	// }

	MonoText {
      id: clock

      anchors {
        horizontalCenter: parent.horizontalCenter
        top: parent.top
        topMargin: 100
      }

      text: Time.currentTime
      color: Config.white
      font.bold: true
      font.pixelSize: 80
	}

  Item {
      id: status

      anchors {
          bottom: parent.bottom
          horizontalCenter: parent.horizontalCenter
      }

      implicitHeight: 60
      implicitWidth: layout.implicitWidth

      End {
          id: layout

          Clickable {
              Icon {
                  id: powerButton
                  iconName: "system-shutdown-symbolic"
                  iconColor: Config.red
              }
          }
      }
  }

	ColumnLayout {
		// Uncommenting this will make the password entry invisible except on the active monitor.
		// visible: Window.active

		anchors {
			horizontalCenter: parent.horizontalCenter
			top: parent.verticalCenter
		}

    TextInput {
        id: passwordBox

        implicitWidth: 400
        padding: General.padding.large

        enabled: !root.context.unlockInProgress
        echoMode: TextInput.Password
        inputMethodHints: Qt.ImhSensitiveData
        bgColor: Config.lighterBackground
        color: Config.white

        // Update the text in the context when the text in the box changes.
        onTextChanged: root.context.currentText = this.text;

        // Try to unlock when enter is pressed.
        onAccepted: root.context.tryUnlock();

        // Update the text in the box to match the text in the context.
        // This makes sure multiple monitors have the same text.
        Connections {
            target: root.context

            function onCurrentTextChanged() {
              passwordBox.text = root.context.currentText;
            }
        }
    }

      MonoText {
          color: Colors.md3.error
          visible: root.context.showFailure
          text: "Incorrect password"
      }
	}
}
