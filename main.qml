import QtQuick 2.2
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

import Server 1.0
import Client 1.0

import "./function.js" as Functional

ApplicationWindow
{
    id:root
    width: 1280
    height: 860
    visible: true
    title: qsTr("QOpenChat")
    background: Rectangle {
        anchors.fill: parent
        color: "black"
    }
    flags: Qt.FramelessWindowHint

    property int icon_size: 30

    Server_Tcp
    {
        id:server
        onNewConnect:
        {
            sys_info.text = server.rText;
        }
        onReadyRead:
        {
            sys_info.text = server.rText;
        }
    }

    Client_Tcp
    {
        id:client
        onConnect_success:
        {
            sys_info.text = client.cInfo;
            repeater.model.insert(repeater.model.count,{"name":"client","value":15})
        }
    }

    menuBar: MenuBar
    {
        id:mBar
        background:Rectangle
        {
            anchors.fill:parent
            color:"lightblue"

            MouseArea
            {
                anchors.fill: parent
                property variant clickPos: "1,1"
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
                width: icon_size
                height: icon_size
                icon.source: "qrc:/icon/open.png"
                icon.width: icon_size
                icon.height: icon_size
                ToolTip.text: "Open Tcp Server"
                ToolTip.visible: hovered

                onClicked:
                {
                    server.start()
                    server.isListen() ? sys_info.text = qsTr("server is listening..."): sys_info.text = qsTr("server open failed")

                    console.log(server.ipAddr)
                    console.log(server.port)

                    client.ip = server.ipAddr;
                    client.port = server.port;
                }
            }
            ToolButton
            {
                width: icon_size
                height: icon_size
                icon.source: "qrc:/img/closeServer.png"
                icon.width: icon_size
                icon.height: icon_size
                ToolTip.text: "Close Tcp Server"
                ToolTip.visible: hovered
                onClicked:
                {
                    client.start();
                   sys_info.text = qsTr(client.cInfo);
                }
            }
            ToolButton
            {
                width: icon_size
                height: icon_size
                icon.source: "qrc:/icon/file.png"
                icon.width: icon_size
                icon.height: icon_size
                ToolTip.text: "Choose File"
                ToolTip.visible: hovered
            }
            ToolButton
            {
                width: icon_size
                height: icon_size
                icon.source: "qrc:/icon/picture.png"
                icon.width: icon_size
                icon.height: icon_size
                ToolTip.text: "Choose Picture"
                ToolTip.visible: hovered
            }
            ToolButton
            {
                width: icon_size
                height: icon_size
                icon.source: "qrc:/icon/video.png"
                icon.width: icon_size
                icon.height: icon_size
                ToolTip.text: "Choose Video"
                ToolTip.visible: hovered

                onClicked:
                {
                    client.start()
                }
            }
            Label
            {
                text: "WorkBench Platform"
                width: icon_size
                height: icon_size
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
                font.pointSize: 20
                font.family: "微软雅黑"
            }
            ToolButton
            {
                width: icon_size
                height: icon_size
                icon.source: "qrc:/img/min.png"
                icon.width: icon_size
                icon.height: icon_size
                ToolTip.text: qsTr("show normal")
                ToolTip.visible: hovered

                onClicked:
                {
                    root.showNormal()
                }
            }
            ToolButton
            {
                width: icon_size
                height: icon_size
                icon.source: "qrc:/img/max.png"
                icon.width: icon_size
                icon.height: icon_size
                ToolTip.text: qsTr("full screen")
                ToolTip.visible: hovered

                onClicked:
                {
                    root.showFullScreen()
                }
            }
            ToolButton
            {
                width: icon_size
                height: icon_size
                icon.source: "qrc:/icon/skin.png"
                icon.width: icon_size
                icon.height: icon_size
                ToolTip.text: "change skin"
                ToolTip.visible: hovered

                onClicked:
                {
                    repeater.model.insert(repeater.model.count,{"name":qsTr("Btn"),"value":15})
                }
            }
            ToolButton
            {
                width: icon_size
                height: icon_size
                icon.source: "qrc:/img/winClose.png"
                icon.width: icon_size
                icon.height: icon_size
                ToolTip.text: "close window"
                ToolTip.visible: hovered

                onClicked:
                {
                    root.close()
                }
            }
         }
    }
    footer:Rectangle
    {
        id: bar
        height:icon_size
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
            id:rowl
            anchors.fill: parent
            spacing: 10
            Layout.alignment: Qt.SizeAllCursor
            Text
            {
                id: sys_info
                height: parent.height
                text: qsTr(" [sys] initialized......")
                font.pointSize: 10
                font.family: "Consolas"
                Layout.alignment: Qt.AlignLeft
            }
            Text
            {
                id:showtime
                text: "[ system time ] " + Qt.formatDateTime(new Date(),"yyyy-MM-dd HH:mm:ss") + " "
                height: icon_size
                Layout.alignment: Qt.AlignRight
            }
            Rectangle
            {
                height: bar.height
                width: 100
                color: "transparent"
                Layout.alignment:Qt.AlignRight

                MouseArea
                {
                    property variant holdPos: "0,0"
                    anchors.fill: parent
                    cursorShape: Qt.SizeFDiagCursor

                    onPressed:
                    {
                        holdPos  = Qt.point(mouseX,mouseY)
                    }

                    onPositionChanged:
                    {
                        var delta = Qt.point(mouseX-holdPos.x, mouseY-holdPos.y)
                        if(root.width + delta.x > root.minimumWidth)
                        {
                            root.setWidth(root.width + delta.x);
                        }
                        else
                        {
                            root.setWidth(root.minimumWidth);
                        }

                        if(root.height + delta.y > root.minimumHeight)
                        {
                            root.setHeight(root.height + delta.y)
                        }
                        else
                        {
                            root.setHeight(root.minimumHeight)
                        }
                    }
                }
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

    Flickable
    {
        id:contain
        width: 200
        height: parent.height
        contentHeight: parent.height * 10

        Column
        {
            id:content
            y:10
            spacing: 10
            Repeater
            {
                id:repeater
                model: ListModel
                {

                }
                Button
                {
                    width: 200
                    height: 60
                    background: Rectangle
                    {
                        anchors.fill:parent
                        color:"lightgreen"
                    }
                    text: name + value
                }
            }

        }

        Rectangle
        {
            width: 5
            height: parent.height
            x:parent.width + 5
            color: "white"
        }
    }
}
