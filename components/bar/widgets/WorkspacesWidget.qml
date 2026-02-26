import QtQuick
import Quickshell.Hyprland
import "../../../themes"

Rectangle {
    id: root
    color: theme.primary
    height: 24
    width: row.width
    radius: height / 2
    property string screen

    function classToIcon(cls) {
        if (!cls)
            return "";
        var c = cls.toString().toLowerCase();
        let iconsMap = {
            'oss-code': '',
            'code': '',
            'kitty': '',
            'firefox': '',
            'brave-browser': '',
            'steam': '',
            'teamspeak-client': '',
            'vesktop': ''
        };

        return iconsMap[c] ?? '󱂬';
    }
    function rawEventHandler(event) {
        if (event.name === 'activewindow') {
            Hyprland.refreshToplevels();
        }
    }
    CrimsonNight {
        id: theme
    }
    Row {
        id: row
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        spacing: 8

        Repeater {
            model: Hyprland.workspaces.values.filter(function (w) {
                return w.monitor?.name === screen && w.toplevels.values.length;
            })
            delegate: Item {
                id: itemWrap
                property var activeTop: (modelData.toplevels && modelData.toplevels.values && modelData.toplevels.values.length) ? modelData.toplevels.values[0] : null
                property string activeClass: activeTop && activeTop.lastIpcObject ? (activeTop.lastIpcObject.class || "") : ""
                property string classGlyph: classToIcon(activeClass)
                height: root.height
                width: iconText.width + 24

                Rectangle {
                    anchors.fill: parent
                    color: (Number(modelData.id) === Hyprland.monitors.values.find(function (m) {
                            return m.name === screen;
                        })?.activeWorkspace.id) ? theme.secondary : theme.primary
                    radius: height / 2
                    Text {
                        id: iconText
                        text: classGlyph !== "" ? classGlyph : (activeClass ? activeClass.charAt(0).toUpperCase() : "?")
                        color: (Number(modelData.id) === Hyprland.monitors.values.find(function (m) {
                                return m.name === screen;
                            })?.activeWorkspace.id) ? theme.primary : theme.secondary
                        font.pixelSize: 16
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        Hyprland.rawEvent.connect(rawEventHandler);
    }
}
