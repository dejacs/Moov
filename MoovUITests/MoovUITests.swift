//
//  MoovUITests.swift
//  MoovUITests
//
//  Created by Jade Silveira on 01/12/21.
//

import XCTest

final class MoovUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    }
    
    func testMovieListSwipeUp() throws {
        app.launch()
        
        app.tables["searchResultTable"].swipeUp()
    }
    
    func testMovieCellTap() throws {
        app.launch()
        
        app.tables["searchResultTable"].cells["movieCell"].firstMatch.tap()
    }
    
    func testMovieDetailsSwipeUp() throws {
        app.launch()
        
        let searchResultTable = app.tables["searchResultTable"]
        
        if searchResultTable.isSelected {
            XCTAssertTrue(searchResultTable.exists)
        }
        
        let movieCell = searchResultTable.cells["movieCell"].firstMatch
        
        if movieCell.isSelected {
            XCTAssertTrue(movieCell.exists)
        }
        
        movieCell.tap()
        
        let movieDetailsScrollView = app.scrollViews["movieDetailsScrollView"]
        
        if movieDetailsScrollView.isSelected {
            XCTAssertTrue(movieDetailsScrollView.exists)
        }
        
        movieDetailsScrollView.swipeUp()
    }
}
