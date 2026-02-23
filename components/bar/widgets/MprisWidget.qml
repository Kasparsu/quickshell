// ClockWidget.qml
import QtQuick
import Quickshell.Services.Pipewire
import Quickshell.Services.Mpris
import "../../../themes"

Rectangle {
    color: theme.primary

    height: 24
    radius: height / 2
    function getDeviceIcon(description) {
        let iconMap = {
            'Built-in Audio Analog Stereo': '󰽟',
            'Galaxy Buds Live (1C8F)': ''
        };
        return iconMap[description] || '󰽟';
    }
    width: container.width

    CrimsonNight {
        id: theme
    }
    anchors.verticalCenter: parent.verticalCenter
    Row {
        id: container
        anchors.verticalCenter: parent.verticalCenter
        leftPadding: 8
        rightPadding: 8
        spacing: 4
        Text {
            id: playbackStatusText
            color: theme.secondary
            text: Mpris.players.values[0].trackArtist + " - " + Mpris.players.values[0].trackTitle
        }
        Text {
            id: deviceName
            color: theme.secondary
            text: getDeviceIcon(Pipewire.defaultAudioSink.description)
        }
        PwObjectTracker {
            id: sinkTracker
            objects: Pipewire.defaultAudioSink
        }
        Text {
            id: volumeText
            color: theme.secondary
            text: Math.round(Pipewire.defaultAudioSink.audio.volume * 100) + "%"
        }
    }
}
