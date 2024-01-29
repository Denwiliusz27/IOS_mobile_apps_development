//
//  AlarmFunctions.swift
//  Tests
//
//  Created by Daniel_UJ on 28/01/2024.
//

struct AlarmFunctions {
    func addHour(hour: String) -> (Bool, String, String) {
        if hour != "" && hour.isInt {
            if hour == "23" {
                return (false, "", "0")
            } else {
                return (false, "", String((Int(hour)!) + 1))
            }
        } else {
            return (true, "Hour should be number between 0 and 23", hour)
        }
    }
    
    func substractHour(hour: String) -> (Bool, String, String) {
        if hour != "" && hour.isInt {
            if hour == "0" {
                return (false, "", "23")
            } else {
                return (false, "", String((Int(hour)!) - 1))
            }
        } else {
            return (true, "Hour should be number between 0 and 23", hour)
        }
    }
    
    func addMinute(minute: String) -> (Bool, String, String) {
        if minute != "" && minute.isInt {
            if minute == "59" {
                return (false, "", "0")
            } else {
                return (false, "", String((Int(minute)!) + 1))
            }
        } else {
            return (true, "Minute should be number between 0 and 59", minute)
        }
    }
    
    func substractMinute(minute: String) -> (Bool, String, String) {
        if minute != "" && minute.isInt {
            if minute == "0" {
                return (false, "", "59")
            } else {
                return (false, "", String((Int(minute)!) - 1))
            }
        } else {
            return (true, "Minute should be number between 0 and 59", minute)
        }
    }
    
    func addAlarm(availableDays: [String], alarmList: [Alarm], day: String, hour: String, minute: String) -> (Bool, [Alarm], String) {
        if day == "" {
            return (true, alarmList, "Fill day input")
        }
        
        if !availableDays.contains(day){
            return (true, alarmList, "Inapropriate day name")
        }
        
        for alarm in alarmList {
            if String(alarm.day) == day && String(alarm.hour) == hour && String(alarm.minute) == minute {
                return (true, alarmList, "Alarm for this day and time already exist")
            }
        }
        
        if hour == "" || minute == "" {
            return (true, alarmList, "Fill hour and minute")
        }
        
        if !hour.isInt || Int(hour)! > 23 || Int(hour)! < 0 {
            return (true, alarmList, "Hour should be number between 0 and 23")
        }
        
        if !minute.isInt || Int(minute)! > 59 || Int(minute)! < 0 {
            return (true, alarmList, "Minute should be number between 0 and 59")
        }
        
        let newAlarm = Alarm(day: day, hour: Int(hour)!, minute: Int(minute)!)
        var newAlarmList = alarmList
        newAlarmList.append(newAlarm)
        return (false, newAlarmList, "")
    }
}
