import Qt 4.7

import "redditengine.js" as RE

Rectangle {

    property bool loggedIn: false

    Connections {
        target: mdlRedditSession
        onLoginResponse: {
            //console.log("Resp is ", response)
            var cook = mdlRedditSession.cookies()
            RE.dump(cook)
            if (cook.reddit_session) {
                loggedIn = true
            } else {
                aLoginBounce.start()

            }

        }
    }

    Column {
        anchors.centerIn: parent
        Row {
            Text {
                text: "Username"

            }

            Item { width: 20; height: 1 }

            TextInput {

                id: inpUserName
                text: "qmtest"
                width: 200
                Rectangle {
                    border.width: 1
                    z: parent.z - 1
                    anchors {
                        fill: parent
                        topMargin: -1
                        bottomMargin: -1
                        leftMargin: -1
                        rightMargin: -1
                    }

                }

            }

        }

        Item {
            height: 20
            width: 1
        }

        Row {
            Text {
                text: "Password"
            }
            Item { width: 20; height: 1 }

            TextInput {
                id: inpPassword
                text: "qmtest"
                width: 200
                echoMode: TextInput.Password
                Rectangle {
                    border.width: 1
                    z: parent.z - 1
                    anchors {
                        fill: parent
                        topMargin: -1
                        bottomMargin: -1
                        leftMargin: -1
                        rightMargin: -1
                    }

                }
            }

        }

    }

    RButton {
        id: btnLogin
        anchors {
            right: parent.right
            bottom: parent.bottom

            rightMargin: 40
            bottomMargin: 30
        }

        buttonLabel: loggedIn? "Logout" : "Login"
        color: loggedIn ? "blue" : "red"

        onClicked: {
            mdlRedditSession.login( inpUserName.text, inpPassword.text)

        }

    }
    SequentialAnimation {
        id: aLoginBounce

        running: false

        PropertyAnimation {
            target: btnLogin
            property: "anchors.bottomMargin"
            to: 100

            duration: 400
            easing.type: Easing.InQuad
        }
        PropertyAnimation {
            target: btnLogin
            property: "anchors.bottomMargin"
            to: 30

            duration: 400
            easing.type: Easing.InQuad

        }
    }


}
