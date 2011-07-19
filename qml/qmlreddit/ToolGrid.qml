import Qt 4.7

import "redditengine.js" as RE


Item {

    Rectangle {
        anchors.fill: parent
        opacity: 0.8
        color: mainview.theme.bg
    }

    ListModel {
        id: toolsModel
        ListElement {
            label: "pics/system-shutdown.svg"
            name: "quit"

        }

        ListElement {
            label: "pics/accessories-dictionary.svg"
            name: "cat"
        }
        ListElement {

            label: "pics/applications-internet.svg"
            name: "browser"
        }
        ListElement {
            label: "pics/preferences-other.svg"
            name: "prefs"
        }

        ListElement {
            label: "pics/view-fullscreen.svg"
            name: "viewsize"
        }
        ListElement {
            label : "pics/twitter_logo.svg"
            name: "twitter"
        }
    }


    Component {
        id: dlgbutton
        ImgButton {
            id: te
            buttonImage: label
            //buttonLabel: label
            width: 100
            height: 100
            color: mainview.theme.bg
            bgOpacity: 1
            pressedColor: "green"
            borderColor: "yellow"

            onClicked: {
                itemSelected(name)

                //root.state = "small"
            }

        }
    }

    GridView {
        model: toolsModel
        delegate: dlgbutton
        anchors.centerIn: parent
        anchors.fill: parent
        cellWidth: 150
        cellHeight: 120
        boundsBehavior: Flickable.StopAtBounds

    }


    Component {
        id: cExcSelector
        RButton {
            property string sel : ""

            buttonLabel: sel
            selected: appState.linkSelection == sel
            onClicked: {
                appState.linkSelection = sel
            }
        }

    }


    Grid {
        anchors.bottom: parent.bottom
        columns: 3
        spacing: 5
        Repeater {
            model: ["Hot", "New", "Top", "Saved", "Contr"]
            RButton {
                buttonLabel: modelData
                selected: appState.linkSelection == modelData

                onClicked: {
                    appState.linkSelection = modelData                    
                    //RE.eng().fetchLinks()
                }

            }
        }

    }

    function itemSelected(itemName) {
        toolgrid.state = ""
        if (itemName == "cat") {
            if (!priv.myRedditsFetched) {
                mdlRedditSession.getMyReddits()
                priv.myRedditsFetched = true
            }
            viewSwitcher.switchView(categoryselector, true)
            mainview.state = "SelectCategory"

        }
        if (itemName == "quit") {
            Qt.quit()
        }
        if (itemName == "browser") {
            var lnk = RE.eng().currentLink()
            if (lnk.permalink) {
                mainview.openUrl("http://www.reddit.com" + lnk.permalink)

            } else {
                mainview.openUrl("http://www.reddit.com")
            }
        }
        if (itemName == "prefs") {
            viewSwitcher.switchView(settingsview, true)
            mainview.state = "SettingsState"

        }

        if (itemName == "viewsize") {
            lifecycle.toggleState()
        }

        if (itemName == "twitter") {
            var lnk = RE.eng().currentLink()
            if (!lnk || !lnk.url) {
                infoBanner.show("No link selected")
                return
            }


            var cookedurl = "";
            var cookeddesc = ""
            if (hostOs == "maemo5") {
                cookedurl = lnk.url
                cookeddesc = lnk.desc

            } else {
                cookedurl = escape(lnk.url)
                //cookedurl = lnk.url
                cookeddesc = escape(lnk.desc)
            }


            var u;

            if (hostOs == "symbian") {
                u = "http://twitter.com/share?via=qmlreddit&url=" + cookedurl
            } else {
              var u = "http://twitter.com/share?url=" + cookedurl+"&text=" + cookeddesc + "&via=qmlreddit"
            }

            //console.log("Launch " + u)
            mainview.openUrl(u)

            //mdlReddit.browser("http://twitter.com/home?status=" + msg)

        }

        //console.log("Select item ", itemName)
    }

}
