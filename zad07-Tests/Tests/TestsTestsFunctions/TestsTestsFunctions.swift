//
//  TestsTestsFunctions.swift
//  TestsTestsFunctions
//
//  Created by Daniel_UJ on 29/01/2024.
//

import XCTest
@testable import Tests

final class TestsTestsFunctions: XCTestCase {
    func testAddHour() throws {
        let alarm = AlarmFunctions()
        let result1 = alarm.addHour(hour: "20")
        XCTAssertEqual(result1.0, false)
        XCTAssertEqual(result1.1, "")
        XCTAssertEqual(result1.2, "21")
        
        let result2 = alarm.addHour(hour: "23")
        XCTAssertEqual(result2.0, false)
        XCTAssertEqual(result2.1, "")
        XCTAssertEqual(result2.2, "0")
        
        let result3 = alarm.addHour(hour: "20abc")
        XCTAssertEqual(result3.0, true)
        XCTAssertEqual(result3.1, "Hour should be number between 0 and 23")
        XCTAssertEqual(result3.2, "20abc")
    }
    
    func testSubstractHour() throws {
        let alarm = AlarmFunctions()
        let result1 = alarm.substractHour(hour: "20")
        XCTAssertEqual(result1.0, false)
        XCTAssertEqual(result1.1, "")
        XCTAssertEqual(result1.2, "19")
        
        let result2 = alarm.substractHour(hour: "0")
        XCTAssertEqual(result2.0, false)
        XCTAssertEqual(result2.1, "")
        XCTAssertEqual(result2.2, "23")
        
        let result3 = alarm.substractHour(hour: "20abc")
        XCTAssertEqual(result3.0, true)
        XCTAssertEqual(result3.1, "Hour should be number between 0 and 23")
        XCTAssertEqual(result3.2, "20abc")
    }
    
    func testAddMinute() throws {
        let alarm = AlarmFunctions()
        let result1 = alarm.addMinute(minute: "20")
        XCTAssertEqual(result1.0, false)
        XCTAssertEqual(result1.1, "")
        XCTAssertEqual(result1.2, "21")
        
        let result2 = alarm.addMinute(minute: "59")
        XCTAssertEqual(result2.0, false)
        XCTAssertEqual(result2.1, "")
        XCTAssertEqual(result2.2, "0")
        
        let result3 = alarm.addMinute(minute: "20abc")
        XCTAssertEqual(result3.0, true)
        XCTAssertEqual(result3.1, "Minute should be number between 0 and 59")
        XCTAssertEqual(result3.2, "20abc")
    }
    
    func testSubstractMinute() throws {
        let alarm = AlarmFunctions()
        let result1 = alarm.substractMinute(minute: "20")
        XCTAssertEqual(result1.0, false)
        XCTAssertEqual(result1.1, "")
        XCTAssertEqual(result1.2, "19")
        
        let result2 = alarm.substractMinute(minute: "0")
        XCTAssertEqual(result2.0, false)
        XCTAssertEqual(result2.1, "")
        XCTAssertEqual(result2.2, "59")
        
        let result3 = alarm.substractMinute(minute: "20abc")
        XCTAssertEqual(result3.0, true)
        XCTAssertEqual(result3.1, "Minute should be number between 0 and 59")
        XCTAssertEqual(result3.2, "20abc")
    }
    
    func testAddAlarm() throws {
        let alarm = AlarmFunctions()
        let availableDays: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        let alarmList: [Alarm] = [
            Alarm(day: "Monday", hour: 6, minute: 55),
        ]
        
        let result1 = alarm.addAlarm(availableDays: availableDays, alarmList: alarmList, day: "Monday", hour: "12", minute: "30")
        XCTAssertEqual(result1.0, false)
        XCTAssertEqual(result1.2, "")
        
        let result2 = alarm.addAlarm(availableDays: availableDays, alarmList: alarmList, day: "Manday", hour: "12", minute: "30")
        XCTAssertEqual(result2.0, true)
        XCTAssertEqual(result2.2, "Inapropriate day name")
        
        let result3 = alarm.addAlarm(availableDays: availableDays, alarmList: alarmList, day: "", hour: "12", minute: "30")
        XCTAssertEqual(result3.0, true)
        XCTAssertEqual(result3.2, "Fill day input")
        
        let result4 = alarm.addAlarm(availableDays: availableDays, alarmList: alarmList, day: "Monday", hour: "6", minute: "55")
        XCTAssertEqual(result4.0, true)
        XCTAssertEqual(result4.2, "Alarm for this day and time already exist")
        
        let result5 = alarm.addAlarm(availableDays: availableDays, alarmList: alarmList, day: "Monday", hour: "", minute: "55")
        XCTAssertEqual(result5.0, true)
        XCTAssertEqual(result5.2, "Fill hour and minute")
        
        let result6 = alarm.addAlarm(availableDays: availableDays, alarmList: alarmList, day: "Monday", hour: "31", minute: "55")
        XCTAssertEqual(result6.0, true)
        XCTAssertEqual(result6.2, "Hour should be number between 0 and 23")
        
        let result7 = alarm.addAlarm(availableDays: availableDays, alarmList: alarmList, day: "Monday", hour: "12", minute: "98")
        XCTAssertEqual(result7.0, true)
        XCTAssertEqual(result7.2, "Minute should be number between 0 and 59")
    }
}
