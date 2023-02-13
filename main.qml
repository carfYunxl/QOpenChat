import QtQuick 2.2
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Server 1.0
import Client 1.0

ApplicationWindow
{
    id:root
    width: 1280
    height: 860
    visible: true
    title: qsTr("QOpenChat")
    background: Image {
        source: "qrc:/img/bp1.jpg"
    }
    flags: Qt.FramelessWindowHint

    Server_Tcp
    {
        id:server
        onNewConnect:
        {
            edit_server.text = server.rText;
        }
        onReadyRead:
        {
            edit_server.text = server.rText;
        }
    }

    Client_Tcp
    {
        id:client
        onConnect_success:
        {
            edit_client.append(client.cInfo);
        }
    }

    menuBar: MenuBar
    {
        id:mBar
        background:Rectangle
        {
            anchors.fill:parent
            color:"lightblue"
        }
        Menu
        {
            title: qsTr("&File")
            Action {
                text: qsTr("&New...")
            }
            Action { text: qsTr("&Open...") }
            Action { text: qsTr("&Save") }
            Action { text: qsTr("Save &As...") }
            MenuSeparator { }
            Action { text: qsTr("&Quit") }
        }
        Menu
        {
            title: qsTr("&Edit")
            Action { text: qsTr("Cu&t") }
            Action { text: qsTr("&Copy") }
            Action { text: qsTr("&Paste") }
        }
        Menu
        {
            id:help
            title: qsTr("&Help")
            Action { text: qsTr("&About") }
        }
    }

    header: ToolBar
    {
        background:Rectangle
        {
            anchors.fill:parent
            color:"lightgrey"
        }
        RowLayout
        {
            spacing: 10
            anchors.fill: parent
            ToolButton
            {
                width: 50
                height: 50
                icon.source: "qrc:/icon/open.png"
                icon.width: 50
                icon.height: 50
                ToolTip.text: "Open Tcp Server"
                ToolTip.visible: hovered

                onClicked:
                {
                    server.start()
                    server.isListen() ? server_show.append(qsTr("server is listening...")) : server_show.append(qsTr("server open failed"))

                    console.log(server.ipAddr)
                    console.log(server.port)

                    client.ip = server.ipAddr;
                    client.port = server.port;
                }
            }
            ToolButton
            {
                width: 50
                height: 50
                icon.source: "qrc:/img/closeServer.png"
                icon.width: 50
                icon.height: 50
                ToolTip.text: "Close Tcp Server"
                ToolTip.visible: hovered
                onClicked:
                {
                    client.start();
                    client_show.append(qsTr(client.cInfo));
                }
            }
            ToolButton
            {
                width: 50
                height: 50
                icon.source: "qrc:/icon/file.png"
                icon.width: 50
                icon.height: 50
                ToolTip.text: "Choose File"
                ToolTip.visible: hovered
            }
            ToolButton
            {
                width: 50
                height: 50
                icon.source: "qrc:/icon/picture.png"
                icon.width: 50
                icon.height: 50
                ToolTip.text: "Choose Picture"
                ToolTip.visible: hovered
            }
            ToolButton
            {
                width: 50
                height: 50
                icon.source: "qrc:/icon/video.png"
                icon.width: 50
                icon.height: 50
                ToolTip.text: "Choose Video"
                ToolTip.visible: hovered
            }
            Label
            {
                text: "Title"
                width: 50
                height: 50
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
            ToolButton
            {
                width: 50
                height: 50
                icon.source: "qrc:/img/min.png"
                icon.width: 50
                icon.height: 50
                ToolTip.text: qsTr("show normal")
                ToolTip.visible: hovered

                onClicked:
                {
                    root.showNormal()
                }
            }
            ToolButton
            {
                width: 50
                height: 50
                icon.source: "qrc:/img/max.png"
                icon.width: 50
                icon.height: 50
                ToolTip.text: qsTr("full screen")
                ToolTip.visible: hovered

                onClicked:
                {
                    root.showFullScreen()
                }
            }
            ToolButton
            {
                width: 50
                height: 50
                icon.source: "qrc:/img/winClose.png"
                icon.width: 50
                icon.height: 50
                ToolTip.text: "close window"
                ToolTip.visible: hovered

                onClicked:
                {
                    root.close()
                }
            }
            ToolButton
            {
                width: 50
                height: 50
                text: qsTr("⋮")
            }
         }
    }
    footer:Rectangle
    {
        id: bar
        height:50
        width: parent.width
        color:"lightblue"

        MouseArea
        {
            property variant clickPos: "1,1"
            height: parent.height
            width: parent.width
            cursorShape: "PointingHandCursor"
            onPressed:
            {
                clickPos  = Qt.point(mouseX,mouseY)
            }

            onPositionChanged: {
                var delta = Qt.point(mouseX-clickPos.x, mouseY-clickPos.y)
                root.x += delta.x;
                root.y += delta.y;
            }
        }

        RowLayout
        {
            anchors.fill: parent
            spacing: 10
            Layout.alignment: Qt.AlignCenter
            Text
            {
                id: name
                height: parent.height
                text: qsTr(" [sys] initialized......")
//                elide: Text.left
                font.pointSize: 10
                font.family: "Consolas"
                Layout.alignment: Qt.AlignLeft
            }
            Text
            {
                id:showtime
                text: "[ system time ] " + Qt.formatDateTime(new Date(),"yyyy-MM-dd HH:mm:ss") + " "
//                text: "[sys time] " + Date() + " "
                height: 50
                Layout.alignment: Qt.AlignRight
            }
        }
    }

    Timer
    {
        id:timer
        interval: 1000
        repeat: true

        onTriggered:
        {
            showtime.text = "[ system time ] " + Qt.formatDateTime(new Date(),"yyyy-MM-dd HH:mm:ss") + " "
        }
    }

    Component.onCompleted:
    {
        timer.start()
    }
}
