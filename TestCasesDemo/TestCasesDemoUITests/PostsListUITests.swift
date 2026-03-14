//
//  PostsListUITests.swift
//  TestCasesDemo
//
//  Created by Nitin Bhatia on 07/03/26.
//


import XCTest

final class PostsListUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    func test_tapPost_navigatesToDetail() {

        let firstPost = app.staticTexts["postTitle"].firstMatch
        XCTAssertTrue(firstPost.waitForExistence(timeout: 10))
        firstPost.tap()
            

        let detailText = app.staticTexts["postBody"]
        XCTAssertTrue(detailText.waitForExistence(timeout: 10))
    }
}
