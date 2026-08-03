import qs.settings
import qs.services
import qs.modules.common

Clickable {
    id: root

    bgColor: "transparent"
    showShadow: false

    MonoText {
        text: Time.currentTime
        color: Config.white
    }
}
