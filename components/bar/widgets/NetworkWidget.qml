import "../../../themes"
import QtQuick
import Quickshell.Io

Rectangle {
    color: theme.primary
    height: 24
    radius: height / 2
    width: container.width
    anchors.verticalCenter: parent.verticalCenter

    CrimsonNight {
        id: theme
    }

    Row {
        id: container

        anchors.verticalCenter: parent.verticalCenter
        leftPadding: 8
        rightPadding: 8
        spacing: 4
        Text {
            id: networkName
            anchors.verticalCenter: parent.verticalCenter
            color: theme.secondary
            text: ''
        }
        Text {
            id: networkIcon
            font.pixelSize: 16
            color: theme.secondary
            text: ''
        }
    }

    //   // when the timer is triggered, set the running property of the
    //   // process to true, which reruns it if stopped.
    //   onTriggered: console.log(container.activePlayerInfo())
    // }
    Process {
        id: networks
        running: true
        command: ["sh", "-c", "nmcli -t -f TYPE,STATE,CONNECTION d status"]

        stdout: StdioCollector {
            onStreamFinished: {
                let lines = this.text.split('\n').filter(l => l);
                let connections = lines.map(l => l.split(':')).map(a => ({
                            type: a[0],
                            state: a[1],
                            connection: a[2]
                        })).filter(c => c.state === 'connected');
                if (connections.find(c => c.type === 'ethernet')) {
                    networkIcon.text = '󰈀';
                    networkName.text = '';
                } else {
                    wifi.running = true;
                }
            }
        }
    }
    Process {
        id: wifi
        running: false
        command: ["nmcli", "-t", "-f", "IN-USE,SIGNAL,SSID,BARS", "device", "wifi"]

        stdout: StdioCollector {
            onStreamFinished: {
                let active = this.text.split('\n').filter(l => l.startsWith('*')).map(l => l.split(':').map(v => v.trim()))[0];
                if (active) {
                    let bars = active[3] || '';
                    let strength = 4 - (bars.match(/_/g) || []).length;
                    let icons = ['󰤯', '󰤟', '󰤢', '󰤥', '󰤨'];
                    networkIcon.text = icons[strength];
                    networkName.text = active[2];
                } else {
                    networkIcon.text = '󰖪';
                    networkName.text = '';
                }
            }
        }
    }
    // use a timer to rerun the process at an interval
    Timer {
        // 1000 milliseconds is 1 second
        interval: 1000

        // start the timer immediately
        running: true

        // run the timer again when it ends
        repeat: true

        // when the timer is triggered, set the running property of the
        // process to true, which reruns it if stopped.
        onTriggered: networks.running = true
    }
}
