import Qt 4.7
import "toolbar.js" as ToolbarJS

Item {
    id: toolbar
    width: parent.width
    height: parent.height

    // Make children of this Item to be the children of contentArea
    default property alias views: contentArea.children

    property int current: 0
    property int minimumItemHeight: toolbarImage.height//80
    property int minimumItemWidth: toolbarImage.height//80

    onCurrentChanged: ToolbarJS.setContentOpacity()
    Component.onCompleted: ToolbarJS.setContentOpacity()

    // A black background for the item to prevent the white
    // background from showing in any situation
    Rectangle {
        anchors.fill: parent
        color: "black"
    }

    BorderImage {
            id: toolbarImage
            source: "pics/toolbaritem.png"
            width: parent.width

            height: 80
            border.left: 10; border.top: 10
            border.right: 10; border.bottom: 10
    }

    // Flickable area for the toolbar items
    Flickable {
        id: toolbarItemArea
        anchors.bottom: toolbar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: toolbar.minimumItemHeight

        flickableDirection: "HorizontalFlick"
        contentWidth: toolbarItems.width
        contentHeight: toolbarItems.height
        boundsBehavior: Flickable.StopAtBounds

        Row {
            id: toolbarItems

            // Make toolbarItems fill all available horizontal space
            property int itemWidth: ToolbarJS.calcTabWidth()

            Repeater {
                // As many tabs as the parent has children
                id: toolbarItemList
                model: views.length

                delegate: ToolbarItem {
                    width: toolbarItems.itemWidth > contentWidth ? toolbarItems.itemWidth : contentWidth
                    height: toolbar.minimumItemHeight
                }
            }
        }
    }

    // Child objects (i.e. toolbar view contents)
    Item {
        id: contentArea
        width: toolbar.width
        anchors.top: parent.top;
        anchors.bottom: toolbarItemArea.top
    }
}
