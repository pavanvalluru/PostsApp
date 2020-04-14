//
//  PostsAppUITests.swift
//  PostsAppUITests
//
//  Created by Pavan Kumar Valluru on 12.04.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import XCTest

class PostsAppUITests: XCTestCase {

     var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments += ["UITesting"]
    }

    private func getJSONStringFromFileName(name: String) -> String {
        let bundle = Bundle(for: type(of: self))
        if let filePath = bundle.path(forResource: name, ofType: "json") {
            let jsonString = try? String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
            return jsonString ?? ""
        }
        return ""
    }

    private func login() {
        let field = app.textFields["z.B: \"1\""]
        field.tap()
        field.typeText("1\n")
        app.buttons["LOGIN"].tap()
    }

    func testPostsTableViewCells() {
        app.launchEnvironment["https://jsonplaceholder.typicode.com/posts?userId+1"] = getJSONStringFromFileName(name: "testPosts")
        app.launch()

        login()

        let postsTableview = app.tables["postsTable"]
        XCTAssertTrue(postsTableview.exists, "posts tableview exists")

        let tableCells = postsTableview.cells

        if tableCells.count > 0 {
            let count: Int = (tableCells.count - 1)

            let promise = expectation(description: "Wait for table cells")

            for val in stride(from: 0, to: count, by: 1) {
                // Grab the first cell and verify that it exists
                let tableCell = tableCells.element(boundBy: val)
                XCTAssertTrue(tableCell.exists, "The \(val) cell is in place on the table")

                if val == (count - 1) {
                    promise.fulfill()
                }
            }
            waitForExpectations(timeout: 20, handler: nil)
            XCTAssertTrue(true, "Finished validating the table cells")

        } else {
            XCTAssert(false, "Was not able to find any table cells")
        }
    }

    func testCommentsTableView() {
        app.launchEnvironment["https://jsonplaceholder.typicode.com/posts?userId+1"] = getJSONStringFromFileName(name: "testPosts")
        app.launchEnvironment["https://jsonplaceholder.typicode.com/comments?postId+2"] = getJSONStringFromFileName(name: "testComments")
        app.launch()

        login()

        let postsTableview = app.tables["postsTable"]
        XCTAssertTrue(postsTableview.exists, "posts tableview exists")

        let tableCells = postsTableview.cells
        if tableCells.count > 0 {
            let tableCell = tableCells.element(boundBy: 1)
            XCTAssertTrue(tableCell.exists, "The cell is in place on the table")
            tableCell.tap()
            XCTAssertEqual(app.navigationBars.element.identifier, "Comments")
            let commentsTableview = app.tables["commentsTable"]
            XCTAssertTrue(commentsTableview.exists, "comments tableview exists")
            let commentTableCells = commentsTableview.cells
            if commentTableCells.count < 1 {
                XCTAssert(false, "Was not able to find any comment table cells")
            }
        } else {
            XCTAssert(false, "Was not able to find any posts table cells")
        }
    }

    func testForInvalidResultAlert() {
        app.launchEnvironment["https://jsonplaceholder.typicode.com/comments?postId+1"] = nil
        app.launch()

        login()

        let alert = app.alerts["Error"]
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: alert, handler: nil)
        waitForExpectations(timeout: 5.0, handler: nil)

        alert.buttons["Okay"].tap()
        XCTAssertEqual(app.navigationBars.element.identifier, "My Posts")
    }

    func testNoNetworkAlert() {
        app.launchEnvironment["Offline"] = "1"
        app.launch()

        // Relaunch app without restarting it
        app.activate()

        login()

        let alert = app.alerts["Error"]
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: alert, handler: nil)
        waitForExpectations(timeout: 5.0, handler: nil)

        XCTAssert(app.alerts.element.staticTexts["Mocked Internet connection appears to be offline."].exists)

        alert.buttons["Okay"].tap()
        XCTAssertEqual(app.navigationBars.element.identifier, "My Posts")
    }

}
