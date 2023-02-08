import QtQuick 2.2
import QtQuick.Window
import QtQuick.Controls 2.5

Window
{
    id:root
    width: 1280
    height: 860
    visible: true
    title: qsTr("QOpenChat")

    Window
    {
        id:child
        width: 400
        height: 300
        visible: true
        title: qsTr("child")
    }

    Rectangle
    {
        id:background
        color: "lightblue"
        anchors.fill: parent


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
