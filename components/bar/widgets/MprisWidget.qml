import "../../../singletons"
// ClockWidget.qml
import QtQuick
import Quickshell.Services.Pipewire
import "../../../themes"

Rectangle {
    color: theme.primary
    /* height and width follow the Text so the Rectangle wraps snugly */
    height: 24
    width: deviceName.width + 16
    radius: height / 2
    
    CrimsonNight { id: theme }
    anchors.verticalCenter: parent.verticalCenter
    Text {
        id: deviceName
        anchors.centerIn: parent
        color: theme.secondary
        text: Pipewire.defaultAudioSource.nickname
    }
    Text {
        id: timeText
        anchors.centerIn: parent
        color: theme.secondary
        text: Pipewire.defaultAudioSource.nickname
    }
}
