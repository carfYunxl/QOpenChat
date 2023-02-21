import QtQuick 2.2
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3


import Server 1.0

ApplicationWindow
{
    id:root
    width: 800
    height: 580
    visible: true
    title: qsTr("QOpenChat")
    background: Image {
        anchors.fill: parent
        source: "qrc:/img/bp1.jpg"
    }
    flags: Qt.FramelessWindowHint

    property int icon_size: 30

    Server_Tcp
    {
        id:server
        onNewConnect: function(port)
        {
            sys_info.text = server.rText;
            repeater.model.insert(repeater.model.count,{"port":port})
        }
        onReadyRead :function(port)
        {
            info_box.appendText(server.rText)
        }

        onClient_offline: function(port)
        {
            for(var i = 0;i < repeater.count;++i)
            {
                if(repeater.model.get(i).port === port)
                {
                    console.log(i)
                    repeater.model.remove(i);
                    break;
                }
            }

            sys_info.text = qsTr("user " + port + "now offline...")
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
        id:mToolBar
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
                icon.color: "teal"
                ToolTip.text: "Open Tcp Server"
                ToolTip.visible: hovered

                onClicked:
                {
                    server.start()
                    server.isListen() ? sys_info.text = qsTr("server is listening..."): sys_info.text = qsTr("server open failed")
                }
            }
            ToolButton
            {
                width: icon_size
                height: icon_size
                icon.source: "qrc:/img/closeServer.png"
                icon.width: icon_size
                icon.height: icon_size
                icon.color: "teal"
                ToolTip.text: "Close Tcp Server"
                ToolTip.visible: hovered
                onClicked:
                {
                }
            }
            ToolButton
            {
                width: icon_size
                height: icon_size
                icon.source: "qrc:/icon/file.png"
                icon.width: icon_size
                icon.height: icon_size
                icon.color: "teal"
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
                icon.color: "teal"
                ToolTip.text: "Choose Picture"
                ToolTip.visible: hovered
            }

            Label
            {
                text: "Tcp Server Manager"
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
                icon.color: "teal"
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
                icon.color: "teal"
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
                icon.color: "teal"
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
                icon.color: "teal"
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
        id: mFootBar
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
                height: mFootBar.height
                width: 5
                color: "darkgray"
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
					text:port
                    onDoubleClicked:
                    {
                        var item = repeater.itemAt(index)
                        if(item instanceof Button)
                        {
                            input_text.port = item.text
                            input_text.title = qsTr("Client port = ") + item.text
                            input_text.open()
                        }
                    }
                }
            }
        }

        Rectangle
        {
            id:sidebar
            width: 5
            height: parent.height
            x:parent.width + 5
            color: "white"

            MouseArea
            {
                property variant holdPos: "0,0"

                anchors.fill: parent
                cursorShape: Qt.SizeHorCursor

                onPressed:
                {
                    holdPos  = Qt.point(mouseX,mouseY)
                }

                onPositionChanged:
                {
                    var delta = Qt.point(mouseX-holdPos.x, mouseY-holdPos.y)
                    contain.width += delta.x;

                    console.log(repeater.count)

                    for(var i = 0;i < repeater.count;++i)
                    {
                        var item = repeater.itemAt(i)
                        if( item instanceof Button)
                        {
                            item.width += delta.x
                            console.log(item.text)
                        }
                    }
                }
            }
        }
    }

    QO_TextArea
    {
        id:input_text
        w_x:500
        w_y:240
        posx: sidebar.x + sidebar.width + 50
        posy: root.height -input_text.w_y - 100
        title:qsTr("Input")
        onSendInfo: function(text)
        {
            server.sendMsgToClient(input_text.port,text);
            pText = text
        }
        onPosChange: function(x,y)
        {
            if((x - (sidebar.x + sidebar.width)) < 30)
            {
                input_text.x = sidebar.x + sidebar.width;
            }

            if((root.width - input_text.width - x) < 30 )
            {
                input_text.x = root.width - input_text.width
            }

            if((mFootBar.y - input_text.height - y) < 30)
            {
                input_text.y = mFootBar.y - input_text.height
            }

            if((y - root.y) < 30)
            {
                input_text.y = root.y
            }
        }

        onGetFileSrc: function(src)
        {
            console.log(src)
            var str = new String(src)
            console.log(str)
            var srcTxt = qsTr("<img src='") + str.substring(8,str.length) + qsTr("'>")
            info_box.infotext = srcTxt
            server.sendMsgToClient(input_text.port,srcTxt);

        }
    }

    QO_Menu
    {
        id:option_menu

        onSendNormal:
        {
            input_text.open()
        }
    }

    //工作区弹出右键菜单的MouseArea
    Rectangle
    {
        id:text_area
        x:sidebar.x + sidebar.width
        y:0
        width:root.width - contain.width - sidebar.width - 5
        height:root.height - mBar.height - mToolBar.height - mFootBar.height
        color: "transparent"

        MouseArea
        {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            focus: true
            Keys.enabled: true

            onClicked:function(mouse)
            {
                if (mouse.button === Qt.RightButton)
                {
                    option_menu.popup()
                }
            }
        }
        VisibleTextArea
        {
            id:info_box
            anchors.fill: parent

        }
    }
}
