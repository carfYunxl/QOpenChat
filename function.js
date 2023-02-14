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
