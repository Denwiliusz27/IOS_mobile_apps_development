//
//  TestsUITests.swift
//  TestsUITests
//
//  Created by Daniel_UJ on 27/01/2024.
//

import XCTest

final class TestsUITests: XCTestCase {
    var app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testAlarmViewStaticText() throws {
        let alarmTxt = app.staticTexts["Alarms"]
        XCTAssertTrue(alarmTxt.exists)
        
        let hourTxt = app.staticTexts["Hour"]
        XCTAssertTrue(hourTxt.exists)
        
        let minuteTxt = app.staticTexts["Minute"]
        XCTAssertTrue(minuteTxt.exists)
        
        let dayInput = app.textFields["Day"]
        XCTAssertTrue(dayInput.exists)
        
        let hour = app.textFields["Hour"]
        XCTAssertTrue(hour.exists)
        
        let minute = app.textFields["Minute"]
        XCTAssertTrue(minute.exists)
        
        let arrow = XCUIApplication().windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        
        let hourArrowUp = arrow.children(matching: .button).matching(identifier: "Up").element(boundBy: 0)
        XCTAssertTrue(hourArrowUp.exists)
        
        let hourArrowDown = arrow.children(matching: .button).matching(identifier: "Down").element(boundBy: 0)
        XCTAssertTrue(hourArrowDown.exists)
        
        let minuteArrowUp = arrow.children(matching: .button).matching(identifier: "Up").element(boundBy: 1)
        XCTAssertTrue(minuteArrowUp.exists)
        
        let minuteArrowDown = arrow.children(matching: .button).matching(identifier: "Down").element(boundBy: 1)
        XCTAssertTrue(minuteArrowDown.exists)
        
        let collectionViewsQuery = app.collectionViews
        let mondayTxt = collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Monday"]/*[[".cells.staticTexts[\"Monday\"]",".staticTexts[\"Monday\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(mondayTxt.exists)
        
        let timeTxt = collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["6:55"]/*[[".cells.staticTexts[\"6:55\"]",".staticTexts[\"6:55\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(timeTxt.exists)
    }
    
    func testAlarmViewDisplayDayError() throws {
        let submit = app.buttons["Submit"]
        XCTAssertTrue(submit.exists)
        submit.tap()
        
        let errorTxt = app.alerts["ERROR"]
        XCTAssertTrue(errorTxt.exists)
            
        let errorMessage = errorTxt.scrollViews.otherElements.staticTexts["Fill day input"]
        XCTAssertTrue(errorMessage.exists)
        
        let ok = errorTxt.scrollViews.otherElements.buttons["OK"]
        XCTAssertTrue(ok.exists)
        ok.tap()
        
        let dayTextField = app.textFields["Day"]
        dayTextField.tap()
        dayTextField.typeText("Manday")
        XCTAssertEqual(dayTextField.value as! String, "Manday")
        
        submit.tap()
        XCTAssertTrue(errorTxt.exists)
        let errorMessageInapropriateDay = errorTxt.scrollViews.otherElements.staticTexts["Inapropriate day name"]
        XCTAssertTrue(errorMessageInapropriateDay.exists)
        ok.tap()
    }
    
    func testAlarmViewTimeError() throws {
        let dayTextField = app.textFields["Day"]
        dayTextField.tap()
        dayTextField.typeText("Tuesday")

        let submit = app.buttons["Submit"]
        
        /// hour
        let hour = app.textFields["Hour"]
        hour.tap()
        
        let app = XCUIApplication()
        let hourTextField = app.textFields["Hour"]
        hourTextField.tap(withNumberOfTaps: 2, numberOfTouches: 2)
        hour.typeText("12 a.m")
        XCTAssertEqual(hour.value as! String, "12 a.m")
        submit.tap()
        
        let errorTxt = app.alerts["ERROR"]
        XCTAssertTrue(errorTxt.exists)
            
        let errorHourMessage = errorTxt.scrollViews.otherElements.staticTexts["Hour should be number between 0 and 23"]
        XCTAssertTrue(errorHourMessage.exists)
        let ok = errorTxt.scrollViews.otherElements.buttons["OK"]
        XCTAssertTrue(ok.exists)
        ok.tap()
        
        hourTextField.tap(withNumberOfTaps: 3, numberOfTouches: 3)
        hour.typeText("12")
        hourTextField.tap(withNumberOfTaps: 2, numberOfTouches: 2)
        hour.typeText("12")
        let element = XCUIApplication().windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let hourArrowUp = element.children(matching: .button).matching(identifier: "Up").element(boundBy: 0)
        hourArrowUp.tap()
        XCTAssertEqual(hour.value as! String, "13")
        
        /// minute
        let minute = app.textFields["Minute"]
        minute.tap()
        
        let minuteTextField = app.textFields["Minute"]
        minuteTextField.tap(withNumberOfTaps: 2, numberOfTouches: 2)
        minute.typeText("12 a.m")
        XCTAssertEqual(minute.value as! String, "12 a.m")
        submit.tap()
        
        XCTAssertTrue(errorTxt.exists)
            
        let errorMinuteMessage = errorTxt.scrollViews.otherElements.staticTexts["Minute should be number between 0 and 59"]
        XCTAssertTrue(errorMinuteMessage.exists)
        XCTAssertTrue(ok.exists)
        ok.tap()
        
        minuteTextField.tap(withNumberOfTaps: 3, numberOfTouches: 3)
        minute.typeText("12")
        minuteTextField.tap(withNumberOfTaps: 2, numberOfTouches: 2)
        minute.typeText("12")
        let minuteArrowUp = element.children(matching: .button).matching(identifier: "Up").element(boundBy: 1)
        minuteArrowUp.tap()
        XCTAssertEqual(minute.value as! String, "13")
        
        submit.tap()
        let collectionViewsQuery = app.collectionViews
        let newAlarmTxt = collectionViewsQuery.staticTexts["Tuesday"]
        XCTAssertTrue(newAlarmTxt.exists)
        
        let timeTxt = collectionViewsQuery.staticTexts["13:13"]
        XCTAssertTrue(timeTxt.exists)
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
