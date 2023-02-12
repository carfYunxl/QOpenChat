import QtQuick 2.2
import QtQuick.Controls 2.5

Rectangle
{
    id: root
    implicitWidth: 600
    implicitHeight: 50
    color: "lightblue"
    width: awidth
    height: bheight

    property int lastX: 0
    property int lastY: 0
    property alias background_color: root.color
    property alias background_radius: root.radius
    property int inner_control_width:50
    property int inner_control_radius:2
    property int awidth: 0
    property int bheight: 0

    signal pressIdxSignal(var idx)
    signal releaseIdxSignal(var idx)

    function setText(idx,txt)
    {
        var item = getClickBtn(idx)
        item.text = txt
    }

    function setWidth(idx,x)
    {
        var item = getClickBtn(idx)
        item.width = x
    }

    function setIcon(idx,url)
    {
        var item = getClickBtn(idx)
        item.icon.source = url
    }

    function getClickBtn(idx)
    {
        for(var i = 0;i < bar.children.length;++i)
        {
            var item = bar.children[i]
            if( item instanceof Flow)
            {
                for(var j = 0;j < item.children.length;++j)
                {
                    var item2 = item.children[j]
                    if(item2 instanceof Repeater)
                    {
                        return item2.itemAt(idx)
                    }
                }
            }
        }
    }

    function getBtnCount()
    {
        for(var i = 0;i < bar.children.length;++i)
        {
            var item = bar.children[i]
            if( item instanceof Flow)
            {
                for(var j = 0;j < item.children.length;++j)
                {
                    var item2 = item.children[j]
                    if(item2 instanceof Repeater)
                    {
                        return item2.children.length;
                    }
                }
            }
        }
    }

    Flow
    {
        id:flow
        Repeater
        {
            id:repeater
            model: ListModel
            {
            }
            RoundButton
            {
                width: inner_control_width
                height: root.height
                radius: inner_control_radius
                text: name
                onPressed:
                {
                    pressIdxSignal(index)
                }

                onReleased:
                {
                    releaseIdxSignal(index)
                }
            }

        }
        move: Transition
        {
            NumberAnimation { properties: "x,y"; easing.type: Easing.OutBounce }
        }
        add: Transition
        {
            NumberAnimation { properties: "x,y"; easing.type: Easing.OutBounce }
        }
        populate: Transition
        {
            NumberAnimation { properties: "x,y"; from: 200; duration: 100; easing.type: Easing.OutBounce }
        }
    }
    RoundButton
    {
        id:add
        width: inner_control_width
        height: root.height
        anchors.right: move.left
        radius: 2
        icon.source: "qrc:/img/star3.png"
        font.bold: true

        onReleased:
        {
            if((repeater.model.count + 2) * inner_control_width < root.width - 20)
            {
                dlg.open()
            }
            else
            {
                add.text = "full"
                add.enabled = false
            }
        }
    }

    Dialog
    {
        id: dlg
        title: "Input button name!"
        x:100
        y:300
        standardButtons: Dialog.Ok | Dialog.Cancel
        modal: true
        closePolicy:Popup.NoAutoClose

        background: Rectangle
        {
            anchors.fill:parent
            color:"white"
        }

        TextField
        {
            id:text
            anchors.fill: parent
            selectByMouse: true
            hoverEnabled: true
            color:"black"
            background: Rectangle
            {
                id:text_bg
                anchors.fill:parent
                color:"white"
                border.color:"grey"
            }
        }

        onAccepted:
        {
            repeater.model.insert(repeater.model.count,{"name":text.text})
            dlg.close()
        }
        onRejected:
        {
            dlg.close()
        }
    }

    Rectangle
    {
        id:move
        width:20
        height: root.height
        anchors.right: root.right
        color: "grey"
        radius: 2

        MouseArea
        {
            anchors.fill: parent
            cursorShape: Qt.DragMoveCursor
            onPressed:
            {
                lastX = mouseX
                lastY = mouseY
            }
            onPositionChanged:
            {
                if(pressed)
                {
                    root.x += mouseX - lastX
                    root.y += mouseY - lastY
                }
            }
        }

    }
}
