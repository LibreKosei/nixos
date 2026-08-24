import qs.settings
import qs.services
import qs.config
import qs.modules.common

Clickable {
    id: root

    bgColor: "transparent"
    showShadow: false

    MonoText {
        text: Time.currentTime
        color: Colors.md3.on_background
    }

    onClicked: States.showNC = !(States.showNC)
}
