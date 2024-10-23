sub processModel()
    modelContent = m.top.modelContent
    resultsCollection = modelContent.data
    totalRows = resultsCollection.count() / 10

    rowsTitles = ["Trending", "Most viewed"]

    itemIndex = 0
    for x = 0 to totalRows - 1
        rowNode = createObject("roSGNode", "ContentNode") ' This is one row
        rowNode.title = rowsTitles[x]

        for y = 1 to 10
            itemNode = createObject("roSGNode", "ItemModel")
            item = resultsCollection[itemIndex]

            itemNode.modelContent = {data: item}
            itemNode.callFunc("processModel")

            rowNode.appendChild(itemNode)
            itemIndex++
        end for
        m.top.appendChild(rowNode)
    end for
end sub
