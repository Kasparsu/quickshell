// ClockWidget.qml
import QtQuick
import Quickshell.Services.Pipewire

import "../../../themes"

Rectangle {
    color: theme.primary

    height: 24
    radius: height / 2
    function getDeviceIcon(description) {
        let iconMap = {
            'Built-in Audio Analog Stereo': '󰽟',
            'Galaxy Buds Live (1C8F)': '',
            'Arctis Nova Pro Analog Stereo': ''
        };
        return iconMap[description] || description || '';
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
            id: deviceName
            color: theme.secondary
            font.pixelSize: 16
            text: getDeviceIcon(Pipewire.defaultAudioSink?.description)
        }
        PwObjectTracker {
            id: sinkTracker
            objects: [Pipewire.defaultAudioSink]
        }
        Text {
            id: volumeText
            color: theme.secondary
            anchors.verticalCenter: parent.verticalCenter
            text: Math.round(Pipewire.defaultAudioSink?.audio.volume * 100) + "%"
        }
    }
    // Component.onCompleted: {
    //     //console.log(Mpris.players.values.findIndex(p => p.isPlaying));
    // }
    //  Timer {
    //   // 1000 milliseconds is 1 second
    //   interval: 1000

    //   // start the timer immediately
    //   running: true

    //   // run the timer again when it ends
    //   repeat: true

    //   // when the timer is triggered, set the running property of the
    //   // process to true, which reruns it if stopped.
    //   onTriggered: console.log(container.activePlayerInfo())
    // }
}
