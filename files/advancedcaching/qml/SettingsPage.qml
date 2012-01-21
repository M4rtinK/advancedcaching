import QtQuick 1.1
import com.nokia.meego 1.0
import "uiconstants.js" as UI
import "functions.js" as F

Page {
    orientationLock: PageOrientation.LockPortrait
    id: tabSettings
    tools: settingsTools
    Header {
        text: "Settings"
        id: header
    }
    onStatusChanged: {
        if (status == PageStatus.Inactive && rootWindow.pageStack.depth == 1) {
            pageSettings.source = "";
        }
    }

    Flickable {
        anchors.top: header.bottom
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        contentHeight: col1.height
        contentWidth: width
        clip: true

        Column {
            id: col1
            anchors.left: parent.left
            anchors.right: parent.right

            spacing: 16

            Label {
                font.pixelSize: 20
                color: UI.COLOR_INFOLABEL
                text: "geocaching.com user data"
            }

            Label {
                text: "Please make sure to set the <b>language</b> at geocaching.com to <b>english</b> and the date format to <b>01/20/2012</b>. You don't need a premium membership."
                wrapMode: Text.Wrap
                width: col1.width
            }

            Button {
                text: "View profile settings"
                onClicked: {
                    Qt.openUrlExternally("http://www.geocaching.com/account/ManagePreferences.aspx");
                }
                anchors.right: parent.right
            }
            TextField {
                placeholderText: "username"
                width: parent.width
                id: inputUsername
                text: settings.optionsUsername
            }
            TextField {
                placeholderText: "password"
                width: parent.width
                id: inputPassword
                echoMode: TextInput.PasswordEchoOnEdit
                text: settings.optionsPassword
            }
            Button {
                anchors.right: parent.right
                text: "save"
                onClicked: {
                    var pw = inputPassword.text;
                    var un = inputUsername.text;
                    settings.optionsPassword = pw
                    settings.optionsUsername = un
                }
            }

            Label {
                font.pixelSize: 20
                color: UI.COLOR_INFOLABEL
                text: "Website Parser"
            }

            Label {
                text: "You are using version " + controller.parserVersion + " from " + controller.parserDate + ". Update parser if you've troubles downloading geocaches. Use Ovi Store for regular updates."
                wrapMode: Text.Wrap
                width: col1.width
            }

            Item {
                anchors.left: parent.left
                anchors.right: parent.right
                height: 60
                Label {
                    text: "Auto Update"
                    font.weight: Font.Bold
                    font.pixelSize: 26
                    anchors.verticalCenter: parent.verticalCenter
                }

                Switch {
                    anchors.right: parent.right
                    onCheckedChanged: {
                        settings.optionsAutoUpdate = checked
                    }
                    checked: settings.optionsAutoUpdate
                    anchors.verticalCenter: parent.verticalCenter
                }
            }


            Button {
                text: "Check for Updates"
                onClicked: {
                    controller.tryParserUpdate();
                }
                anchors.right: parent.right
            }

            Label {
                font.pixelSize: 20
                color: UI.COLOR_INFOLABEL
                text: "Map Type"
            }

            Grid {
                spacing: 8
                columns: 3
                Repeater {
                    model: settings.mapTypes || emptyList
                    delegate: Rectangle {
                        //text: model.maptype.url
                        Image {
                            id: mapTile
                            source: F.getMapTile(model.maptype.url, 8811, 5378, 14);
                            width: 128;
                            height: 128;
                            anchors.centerIn: parent
                            fillMode: Image.Tile
                        }

                        Label {
                            anchors.left: mapTile.left
                            anchors.leftMargin: 4
                            anchors.bottom: mapTile.bottom
                            anchors.bottomMargin: 4
                            anchors.right: mapTile.right
                            elide: Text.ElideMiddle
                            text: model.maptype.name
                            maximumLineCount: 2
                            wrapMode: Text.Wrap

                        }

                        width: 132;
                        height: 132;
                        color: (model.maptype == settings.currentMapType) ? 'red' : 'grey'
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                console.debug("Setting map type to index " + index)
                                settings.currentMapType = model.maptype
                            }
                        }
                    }
                }
            }



            Label {
                font.pixelSize: 20
                color: UI.COLOR_INFOLABEL
                text: "Map View"
            }

            Item {
                anchors.left: parent.left
                anchors.right: parent.right
                height: 60
                Label {
                    text: "Night View (Black Theme)"
                    font.weight: Font.Bold
                    font.pixelSize: 26
                    anchors.verticalCenter: parent.verticalCenter
                }

                Switch {
                    anchors.right: parent.right
                    onCheckedChanged: {
                        settings.optionsNightViewMode = checked ? 1 : 0
                    }
                    checked: settings.optionsNightViewMode == 1
                    anchors.verticalCenter: parent.verticalCenter
                }
            }


            Item {
                anchors.left: parent.left
                anchors.right: parent.right
                height: 60
                Label {
                    text: "Hide Found Geocaches"
                    font.weight: Font.Bold
                    font.pixelSize: 26
                    anchors.verticalCenter: parent.verticalCenter
                }

                Switch {
                    anchors.right: parent.right
                    onCheckedChanged: {
                        settings.optionsHideFound = checked
                    }
                    checked: settings.optionsHideFound
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Item {
                anchors.left: parent.left
                anchors.right: parent.right
                height: 60
                Label {
                    text: "Show position error on map"
                    font.weight: Font.Bold
                    font.pixelSize: 26
                    anchors.verticalCenter: parent.verticalCenter
                }

                Switch {
                    anchors.right: parent.right
                    onCheckedChanged: {
                        settings.optionsShowPositionError = checked
                    }
                    checked: settings.optionsShowPositionError
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Item {
                anchors.left: parent.left
                anchors.right: parent.right
                height: 60
                Label {
                    text: "Number of logs to download"
                    font.weight: Font.Bold
                    font.pixelSize: 26
                    anchors.verticalCenter: parent.verticalCenter
                }

                TextField {
                    width: 90
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    inputMethodHints: Qt.ImhDigitsOnly

                    text: settings.downloadNumLogs
                    onTextChanged: {
                        settings.downloadNumLogs = parseInt(text)
                    }
                }
            }


            /*
            Label {
                font.pixelSize: 20
                color: UI.COLOR_INFOLABEL
                text: "About"
            }*/

        }
    }
    
    
    
    ToolBarLayout {
        id: settingsTools
        visible: true
        ToolIcon {
            iconId: "toolbar-back" + ((! rootWindow.pageStack.depth || rootWindow.pageStack.depth < 2) ? "-dimmed" : "")// + (theme.inverted ? "-white" : "")
            onClicked: {
                if (rootWindow.pageStack.depth > 1) rootWindow.pageStack.pop();
            }

        }
    }
}
