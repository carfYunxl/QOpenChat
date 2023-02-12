import QtQuick 2.2

Flickable
{
     id: flick
     width: 500
     height: 300

     contentWidth: flick.width
     contentHeight: flick.height
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

     function append(x)
     {
         edit.append(x)
     }

     Rectangle
     {
         anchors.fill: parent
         color: "grey"
         TextEdit
         {
             id: edit
             width: flick.width
             textFormat: TextEdit.RichText
             text: "<b>Hello</b> <i>World!</i>"
             focus: true
             wrapMode: TextEdit.Wrap
             onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
             selectByMouse: true
         }
     }
 }
