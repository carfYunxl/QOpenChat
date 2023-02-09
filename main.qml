import QtQuick 2.2
import QtQuick.Window
import QtQuick.Controls 2.5
import Server 1.0

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
        onReadyRead: {
            edit.text = server.rText;
        }
    }

    Window
    {
        id:child
        width: 400
        height: 300
        visible: true
        title: qsTr("child")
    }

    Button
    {
        id:open
        x:10
        y:10
        width: 100
        height: 50
        text: qsTr("Open Server")
        background: Rectangle
        {
            id:bg
            anchors.fill:parent
            color: "yellow"
        }
        onClicked:
        {
            server.start()
            server.isListen() ? open.text = qsTr("Listening") : open.text = qsTr("Open Failed")
        }
    }

    Rectangle
    {
        id:background
        radius: 5
        x:100
        y:100
        width: 200
        height: 200


        Flickable
        {
             id: flick

             width: background.width
             height: background.height
             anchors.centerIn: background

             contentWidth: edit.paintedWidth
             contentHeight: edit.paintedHeight
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
                 id: edit
                 width: flick.width
                 textFormat: TextEdit.RichText
                 text: "<b>Hello</b> <i>World!</i>"
                 focus: true
                 wrapMode: TextEdit.Wrap
                 onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
             }
         }
    }
}
