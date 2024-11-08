//
//  VkontakteNetworkUITests.swift
//  VkontakteNetworkUITests
//
//  Created by Nikita Krylov on 07.11.2024.
//

import XCTest

final class VkontakteNetworkUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        sut = nil
//        try super.tearDownWithError()
//    }
    
    func testTabBarSelectFriendsScreen() {
        // given
        let friendsScreen = app.buttons["Friends"]
        let appViews = app.collectionViews
        let selectedScreen = appViews/*@START_MENU_TOKEN@*/.navigationBars["Friends"]/*[[".cells.navigationBars[\"Friends\"]",".navigationBars[\"Friends\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let titleFriendScreen = selectedScreen.staticTexts["Friends"]
        // then
        friendsScreen.tap()
        if friendsScreen.isEnabled {
            XCTAssertTrue(titleFriendScreen.exists)
        }
    }
    
    func testSelectFriendProfileScreen() {
        // given
        let friendsScreen = app.buttons["Friends"]
        let appViews = app.collectionViews
        let friendProfileSelectedScreen = appViews
          /*@START_MENU_TOKEN@*/.collectionViews.staticTexts["Мошин"]/*[[".cells.collectionViews",".cells",".buttons[\"Антон, Мошин, Offline\"].staticTexts[\"Мошин\"]",".staticTexts[\"Мошин\"]",".collectionViews"],[[[-1,4,1],[-1,0,1]],[[-1,3],[-1,2],[-1,1,2]],[[-1,3],[-1,2]]],[0,0]]@END_MENU_TOKEN@*/
        let scrollViewsQuery = appViews/*@START_MENU_TOKEN@*/.scrollViews/*[[".cells.scrollViews",".scrollViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let friendElement = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Profile").children(matching: .other).element
        let friendNameLabel = scrollViewsQuery.otherElements.staticTexts["Мошин"]
        let backButton = appViews/*@START_MENU_TOKEN@*/.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]/*[[".cells.navigationBars[\"_TtGC7SwiftUI32NavigationStackHosting\"]",".navigationBars[\"_TtGC7SwiftUI32NavigationStackHosting\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Friends"]
        // then
        friendsScreen.tap()
        if friendsScreen.isEnabled {
            friendProfileSelectedScreen.tap()
            XCTAssertTrue(friendElement.exists)
            XCTAssertTrue(friendNameLabel.exists)
            XCTAssertTrue(backButton.exists)
            backButton.tap()
            XCTAssertTrue(friendsScreen.exists)
        }
    }
    func testTabBarSelectGroupsScreen() {
        // given
        let groupsScreen = app.buttons["Groups"]
        let appViews = app.collectionViews
        let selectedScreen = appViews.navigationBars["Groups"]
        let titleGroupScreen = selectedScreen.staticTexts["Groups"]
        // then
        groupsScreen.tap()
        XCTAssertFalse(titleGroupScreen.exists)
    }
    func testTabBarSelectPhotosScreen() {
        // given
        let photosScreen = app.buttons["Photos"]
        let appViews = app.collectionViews
        let selectedScreen = appViews.navigationBars["Photos"]
        let titlePhotosScreen = selectedScreen.staticTexts["Photos"]
        // then
        photosScreen.tap()
        XCTAssertFalse(titlePhotosScreen.exists)
    }
    func testTabBarSelectOwnProfileScreen() {
        // given
        let ownProfileScreen = app.buttons["Profile"]
        let scrollViewsQuery = app.collectionViews/*@START_MENU_TOKEN@*/.scrollViews/*[[".cells.scrollViews",".scrollViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let elementsQuery = scrollViewsQuery.otherElements
        let profileTitle = elementsQuery.staticTexts["Profile"]
        //let photo = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Profile").children(matching: .other).element.children(matching: .other).element
        let softButton = elementsQuery.buttons["Soft Theme"]
        let darkButton = elementsQuery.buttons["Dark Theme"]
        let lightButton = elementsQuery.buttons["Light Theme"]
        // then
        ownProfileScreen.tap()
        XCTAssertTrue(profileTitle.exists)
        //XCTAssertTrue(photo.exists)
        XCTAssertTrue(softButton.exists)
        XCTAssertTrue(darkButton.exists)
        XCTAssertTrue(lightButton.exists)
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
//
//    @MainActor
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
