import "../../../singletons"
// ClockWidget.qml
import QtQuick

import "../../../themes"

Rectangle {
    color: theme.secondary
    /* height and width follow the Text so the Rectangle wraps snugly */
    height: 24
    width: timeText.width + 16
    radius: height / 2
    
    CrimsonNight { id: theme }
    anchors.verticalCenter: parent.verticalCenter
    Text {
        id: timeText
        anchors.centerIn: parent
        color: theme.primary
        text: Time.date
    }

}
