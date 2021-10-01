//
//  LystAssessmentUITests.swift
//  LystAssessmentUITests
//
//  Created by Vishwanath Kota on 30/09/21.
//

import XCTest

class LystAssessmentUITests: XCTestCase {

    func testNaviagtionFlowOfApplication () throws {
        let app = XCUIApplication()
        let verticalScrollBar14PagesCollectionView = app/*@START_MENU_TOKEN@*/.collectionViews.containing(.other, identifier:"Vertical scroll bar, 14 pages").element/*[[".collectionViews.containing(.other, identifier:\"Horizontal scroll bar, 1 page\").element",".collectionViews.containing(.other, identifier:\"Vertical scroll bar, 14 pages\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        verticalScrollBar14PagesCollectionView.swipeUp()
        
        let cellsQuery = app.collectionViews.cells
        cellsQuery.otherElements.containing(.staticText, identifier:"Arabian Mau").element.swipeUp()
        verticalScrollBar14PagesCollectionView.swipeUp()
        verticalScrollBar14PagesCollectionView.swipeDown()
        cellsQuery.otherElements.containing(.staticText, identifier:"Abyssinian").element.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["https://en.wikipedia.org/wiki/Abyssinian_(cat)"]/*[[".buttons[\"https:\/\/en.wikipedia.org\/wiki\/Abyssinian_(cat)\"].staticTexts[\"https:\/\/en.wikipedia.org\/wiki\/Abyssinian_(cat)\"]",".staticTexts[\"https:\/\/en.wikipedia.org\/wiki\/Abyssinian_(cat)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.scrollViews.otherElements.statusBars.buttons["breadcrumb"]/*[[".windows[\"SBSwitcherWindow\"]",".otherElements[\"AppSwitcherContentView\"]",".otherElements[\"card:com.apple.mobilesafari:sceneID:com.apple.mobilesafari-E5D94E03-8003-46AD-BECF-F79C31A7CE90\"].scrollViews.otherElements.statusBars",".buttons[\"Return to LystAssessment\"]",".buttons[\"breadcrumb\"]",".scrollViews.otherElements.statusBars"],[[[-1,5,3],[-1,2,3],[-1,1,2],[-1,0,1]],[[-1,5,3],[-1,2,3],[-1,1,2]],[[-1,5,3],[-1,2,3]],[[-1,4],[-1,3]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["LystAssessment.CatDetailsView"].buttons["Cats"].tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
