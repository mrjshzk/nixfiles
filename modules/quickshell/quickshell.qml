import QtQuick 2.15
import QtQuick.Controls 2.15
import Quickshell
import Quickshell.Wayland

ShellRoot {
    PanelWindow {
        id: bar

        anchors {
            top: true
            left: true
            right: true
        }

        margins {
            top: 10
            left: 20
            right: 20
        }

        height: 40

        color: "transparent"

        Rectangle {
            id: barBackground
            anchors.fill: parent
            radius: 12
            color: "#2b2b2b"
            opacity: 0.95

            border.color: "#3b3b3b"
            border.width: 1

            // Content area
            Row {
                anchors. fill: parent
                anchors. margins: 10
                spacing:  15

                // Clock
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: Qt.formatDateTime(new Date(), "hh:mm")
                    color: "#ffffff"
                    font.pixelSize: 14

               }

                // Title
                Text {
                    anchors.verticalCenter: parent. verticalCenter
                    text:  "Hyprland Shell"
                    color: "#aaaaaa"
                    font.pixelSize: 13
                }
            }
                   Timer {
                        interval: 1000
                        running: true
                        repeat: true
                        onTriggered: parent.text = Qt.formatDateTime(new Date(), "hh:mm")
                    }

        }
    }
}
