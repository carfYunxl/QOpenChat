import QtQuick 2.2
import QtQuick.Controls 2.5

Rectangle
{
    property alias newWidth: root.width
    property alias newHeight: root.height
    property alias bgcolor:root.color

    id:root
    Rectangle
    {
        id:tool
        width: root.width
        height: root.height * 0.1
        y:0

        Row
        {
            spacing: 5
            Repeater
            {
                model: 3
                Button
                {
                    width: 50
                    height: root.height * 0.1
                    background: Rectangle
                    {
                        anchors.fill:parent
                        radius:5
                        color:"lightgreen"
                    }
                    text: "btn" + index
                }
            }
        }
    }

    Flickable
    {
         id: flick
         width: root.width
         height: root.height * 0.7
         anchors.centerIn: parent

         contentWidth: flick.width
         contentHeight: flick.height
         clip: true

         y:root.height * 0.1

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
             width: root.width
             textFormat: TextEdit.RichText
             text: "<b>Hello</b> <i>World!</i>"
             focus: true
             wrapMode: TextEdit.Wrap
             onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
             selectByMouse: true
         }
     }

    TextArea
    {
        width: root.width
        height: root.height * 0.2

        y:root.height * 0.8

        background: Rectangle
        {
            anchors.fill:parent
            color:"yellow"
        }

    }

}
