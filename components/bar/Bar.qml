import QtQuick
// Bar.qml
import Quickshell
import Quickshell.Hyprland
import "widgets"

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData

            screen: modelData
            implicitHeight: 30
            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
            }

            WorkspacesWidget {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 8
                screen: modelData.name
            }

            Rectangle {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 8
                width: rightContainer.width
                height: 24
                radius: height / 2
                color: 'black'

                Row {
                    id: rightContainer
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter

                    MprisWidget {
                        id: mpris

                        anchors.verticalCenter: parent.verticalCenter
                    }

                    BatteryWidget {
                        id: battery

                        anchors.verticalCenter: parent.verticalCenter
                    }

                    DateWidget {
                        id: date

                        anchors.verticalCenter: parent.verticalCenter
                    }

                    ClockWidget {
                        id: clock

                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }
}
