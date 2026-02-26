import QtQuick
import Quickshell.Services.Mpris
import "../../../themes"

Rectangle {
    color: theme.primary
    visible: container.activePlayer > -1
    height: 24
    radius: height / 2

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
        readonly property int activePlayer: Mpris.players.values.findIndex(p => p.isPlaying)
        function activePlayerInfo() {
            let activePlayer = Mpris.players.values.findIndex(p => p.isPlaying);
            if (activePlayer !== -1) {
                return Mpris.players.values[activePlayer].trackArtist + " - " + Mpris.players.values[activePlayer].trackTitle;
            }
            return '';
        }
        Text {
            id: playbackStatusText
            color: theme.secondary
            text: container.activePlayerInfo()
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
