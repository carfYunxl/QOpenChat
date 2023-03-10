import QtQuick 2.2

Flickable
{
     id: info
     property int infowidth: 500
     property int infoheight : 300
     property alias infotext: edit.text
     function clear_info()
     {
         edit.text = qsTr("")
     }
     function appendText(text)
     {
         edit.append(text)
     }
     width: infowidth
     height: infoheight

     contentWidth: info.width
     contentHeight: info.height
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

     Rectangle
     {
         anchors.fill: parent
         color: "transparent"
         TextEdit
         {
             id: edit
             width: infowidth
             height: infoheight
             textFormat: TextEdit.RichText
             text:qsTr("<img src='file:/Users/yxl/Pictures/mage/bg9.jpg' width=200 height=200>")
             focus: true
             color:"white"
             wrapMode: TextEdit.Wrap
             onCursorRectangleChanged: info.ensureVisible(cursorRectangle)
             selectByMouse: true
         }
     }
 }
