import QtQuick
import Quickshell.Services.UPower
import "../../../themes"

Rectangle {
    color: theme.secondary
    /* height and width follow the Text so the Rectangle wraps snugly */
    height: 24
    width: container.width
    radius: height / 2
    visible: UPower.displayDevice.powerSupply
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
        function icon() {
            if (!UPower.displayDevice.powerSupply) {
                return '󱐥';
            }
            let value = Math.round(UPower.displayDevice.percentage * 10) * 10;
            let charging = UPower.displayDevice.state === 1 ? 'charging_' : ''; // 1 means charging
            let icon = 'nf_md_battery_' + charging + value;
            let iconMap = {
                'nf_md_battery_100': '󰁹',
                'nf_md_battery_90': '󰂂',
                'nf_md_battery_80': '󰂁',
                'nf_md_battery_70': '󰂀',
                'nf_md_battery_60': '󰁿',
                'nf_md_battery_50': '󰁾',
                'nf_md_battery_40': '󰁽',
                'nf_md_battery_30': '󰁼',
                'nf_md_battery_20': '󰁻',
                'nf_md_battery_10': '󰁺',
                'nf_md_battery_0': '󱃍',
                'nf_md_battery_charging_100': '󰂅',
                'nf_md_battery_charging_90': '󰂋',
                'nf_md_battery_charging_80': '󰂊',
                'nf_md_battery_charging_70': '󰢞',
                'nf_md_battery_charging_60': '󰂉',
                'nf_md_battery_charging_50': '󰢝',
                'nf_md_battery_charging_40': '󰂈',
                'nf_md_battery_charging_30': '󰂇',
                'nf_md_battery_charging_20': '󰂆',
                'nf_md_battery_charging_10': '󰢜',
                'nf_md_battery_charging_0': '󰢟'
            };
            return iconMap[icon] || '󰁹'; // default to full battery if not found
        }
        Text {
            id: icon
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 16
            color: theme.primary
            text: container.icon()
        }
        Text {
            id: percentage
            anchors.verticalCenter: parent.verticalCenter
            color: theme.primary
            text: UPower.displayDevice.percentage * 100 + "%"
        }
    }
}
