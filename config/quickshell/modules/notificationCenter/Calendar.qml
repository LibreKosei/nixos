import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import qs.settings
import qs.config
import qs.services
import qs.modules.common

Item {
    id: root

    implicitWidth: 300

    property date selectedDate: new Date()

    FlexboxLayout {
        id: layout

        anchors {
            top: parent.top
            right: parent.right
            left: parent.left
        }

        direction: FlexboxLayout.Column
        gap: General.spacing.medium
        justifyContent: FlexboxLayout.JustifySpaceBetween
        alignItems: FlexboxLayout.AlignCenter

        MonoText {
            id: time

            font.pixelSize: 36
            text: Time.minute
            color: Colors.md3.primary
        }

        Rectangle {
            id: calendarBackground

            Layout.fillWidth: true
            Layout.preferredHeight: calendarLayout.height
            radius: General.radius.medium
            color: Colors.md3.surface_container_low

            FlexboxLayout {
                id: calendarLayout

                anchors {
                    top: parent.top
                    right: parent.right
                    left: parent.left
                }

                direction: FlexboxLayout.Column
                gap: General.spacing.medium

                FlexboxLayout {
                    id: calendarHeader

                    Layout.fillWidth: true
                    Layout.rightMargin: General.margin.large
                    Layout.leftMargin: General.margin.large
                    justifyContent: FlexboxLayout.JustifySpaceBetween

                    MonthSpinner { monthGrid: grid; Layout.preferredWidth: 100; }
                    YearSpinner { monthGrid: grid; Layout.preferredWidth: 100; }
                }

                ColumnLayout {
                    id: calendar

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 0

                    DayOfWeekRow {
                        id: row
                        locale: grid.locale
                        Layout.fillWidth: true
                        delegate: MonoText {
                            width: row.cellWidth
                            height: row.cellHeight
                            text: model.narrowName
                            color: Colors.md3.on_surface_variant    
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }

                    MonthGrid {
                        id: grid

                        Layout.fillWidth: true
                        Layout.preferredHeight: width
                        month: root.selectedDate.getMonth()
                        year: root.selectedDate.getFullYear()
                        locale: Qt.locale()

                        delegate: Item {
                            id: cell

                            implicitWidth: grid.width / 7
                            implicitHeight: this.implicitWidth

                            Rectangle {
                                anchors.fill: parent
                                color: model.today ? Colors.md3.primary : "transparent"
                                radius: General.radius.small
                            }

                            MonoText {
                                anchors.centerIn: parent
                                text: model.day
                                color: model.today ? Colors.md3.on_primary
                                : model.month === grid.month ? Colors.md3.on_surface
                                : Colors.md3.outline_variant
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }

                        // delegate: MonoText {
                        //     width: grid.cellWidth
                        //     height: grid.cellHeight
                        //     text: model.day
                        //     color: model.today
                        //         ? Colors.md3.primary
                        //         : model.month === grid.month ? Colors.md3.on_surface
                        //         : Colors.md3.outline_variant
                        //     horizontalAlignment: Text.AlignHCenter
                        //     verticalAlignment: Text.AlignVCenter
                        // }
                    }
                }
            }
        }
    }
}
