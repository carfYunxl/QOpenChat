import QtQuick 2.2
import QtQuick.Window
import QtQuick.Controls 2.5
import Server 1.0
import Client 1.0

Window
{
    id:root
    width: 1280
    height: 860
    visible: true
    title: qsTr("QOpenChat")

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

    Button
    {
        id:open_server
        x:10
        y:10
        width: 100
        height: 50
        text: qsTr("Open Server")
        background: Rectangle
        {
            id:bg_s
            anchors.fill:parent
            color: "yellow"
            radius:10
        }
        onClicked:
        {
            server.start()
            server.isListen() ? edit_server.append(qsTr("server is listening...")) : edit_server.append(qsTr("server open failed"))

            console.log(server.ipAddr)
            console.log(server.port)

            client.ip = server.ipAddr;
            client.port = server.port;
        }
    }

    Button
    {
        id:open_client
        x:120
        y:10
        width: 100
        height: 50
        text: qsTr("Open Client")
        background: Rectangle
        {
            id:bg_c
            anchors.fill:parent
            color: "lightblue"
            radius:10
        }
        onClicked:
        {
            client.start();
            edit_client.append(qsTr(client.cInfo));
        }
    }

    Rectangle
    {
        id:bg_server
        radius: 5
        x:10
        y:100
        width: 200
        height: 500
        color: "lightgreen"

        Flickable
        {
             id: flick_server

             width: bg_server.width
             height: bg_server.height
             anchors.centerIn: bg_server

             contentWidth: edit_server.paintedWidth
             contentHeight: edit_server.paintedHeight
             clip: true

             function ensureVisible(r)
             {
                 if (contentX >= r.x)
                     contentX = r.x;
                 else if (contentX+width <= r.x+r.width)
                     contentX = r.x+r.width-width;
                 if (contentY >= r.y)
                     contentY = r.y;
                 else if (contentY+height <= r.y+r.height)
                     contentY = r.y+r.height-height;
             }

             TextEdit
             {
                 id: edit_server
                 width: flick_server.width
                 textFormat: TextEdit.RichText
                 text: "<b>Hello</b> <i>World!</i>"
                 focus: true
                 wrapMode: TextEdit.Wrap
                 onCursorRectangleChanged: flick_server.ensureVisible(cursorRectangle)
             }
         }
    }

    Rectangle
    {
        id:bg_client
        radius: 5
        x:220
        y:100
        width: 200
        height: 500
        color: "lightblue"

        Flickable
        {
             id: flick_client

             width: bg_client.width
             height: bg_client.height
             anchors.centerIn: bg_client

             contentWidth: edit_client.paintedWidth
             contentHeight: edit_client.paintedHeight
             clip: true

             function ensureVisible(r)
             {
                 if (contentX >= r.x)
                     contentX = r.x;
                 else if (contentX+width <= r.x+r.width)
                     contentX = r.x+r.width-width;
                 if (contentY >= r.y)
                     contentY = r.y;
                 else if (contentY+height <= r.y+r.height)
                     contentY = r.y+r.height-height;
             }

             TextEdit
             {
                 id: edit_client
                 width: flick_client.width
                 textFormat: TextEdit.RichText
                 text: "<b>Hello</b> <i>World!</i>"
                 focus: true
                 wrapMode: TextEdit.Wrap
                 onCursorRectangleChanged: flick_client.ensureVisible(cursorRectangle)
             }
         }
    }
}
