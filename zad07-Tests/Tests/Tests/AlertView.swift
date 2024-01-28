//
//  AlertView.swift
//  Tests
//
//  Created by Daniel_UJ on 27/01/2024.
//

import SwiftUI

struct AlarmView: View {
    struct Alarm: Identifiable {
        let id = UUID()
        var day: String
        var hour: Int
        var minute: Int
    }
    
    @State private var day: String = ""
    @State private var hour: String = "0"
    @State private var minute: String = "0"
    @State private var error: Bool = false
    @State private var errorMessage: String = ""
    @State var availableDays: [String] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    @State var alarmList: [Alarm] = [
        Alarm(day: "Monday", hour: 6, minute: 55),
    ]
    
    var body: some View{
        VStack {
            Text("Alarms")
                .font(.title)
                .fontWeight(.bold)
                .padding(10)
                .foregroundColor(.blue)
            
            VStack{
                TextInput(inputName: "Day", value: $day)
                VStack{
                    HStack{
                        VStack{
                            VStack{
                                Text("Hour")
                                    .padding(.horizontal, 10)
                                    .foregroundColor(.white)
                                
                                Button(action: {
                                    self.addHour()
                                }) {
                                    Image(systemName: "arrow.up")
                                        .imageScale(.small)
                                        .padding(.vertical, 0)
                                        .padding(.horizontal, 0)
                                        .foregroundColor(.white)
                                }.disabled(hour == "")
                                    .padding()
                                
                                TimeInputField(inputName: "Hour", value: $hour)
                                
                                Button(action: {
                                    self.substractHour()
                                }) {
                                    Image(systemName: "arrow.down")
                                        .imageScale(.small)
                                        .padding(.vertical, 0)
                                        .padding(.horizontal, 0)
                                        .foregroundColor(.white)
                                }.disabled(hour == "")
                                    .padding()
                            }
                        }
                        .background(.blue)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 5)
                        .cornerRadius(10)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        
                        VStack{
                            VStack{
                                Text("Minute")
                                    .padding(.horizontal, 10)
                                    .foregroundColor(.white)
                                
                                Button(action: {
                                    self.addMinute()
                                }) {
                                    Image(systemName: "arrow.up")
                                        .imageScale(.small)
                                        .padding(.vertical, 0)
                                        .padding(.horizontal, 0)
                                        .foregroundColor(.white)
                                }.disabled(minute == "")
                                    .padding()
                                
                                TimeInputField(inputName: "Minute", value: $minute)
                                
                                Button(action: {
                                    self.substractMinute()
                                }) {
                                    Image(systemName: "arrow.down")
                                        .imageScale(.small)
                                        .padding(.vertical, 0)
                                        .padding(.horizontal, 0)
                                        .foregroundColor(.white)
                                }.disabled(minute == "")
                                    .padding()
                            }
                        }
                        .background(.blue)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 5)
                        .cornerRadius(10)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    }
                }
                
                Button(action: {
                    self.addAlarm()
                }) {
                    Text("Submit")
                        .padding()
                        .foregroundColor(.blue)
                        .bold()
                        .background(.white)
                        .cornerRadius(10)
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.blue))
                        .padding(.horizontal, 10)
                }
                .alert(isPresented: $error) {
                    Alert(title: Text("ERROR"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
            
                
            }
            .frame(width: 260, alignment: .center)
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .background(Color.blue)
            .cornerRadius(15)
            .fontWeight(.bold)
            .font(.system(size: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.blue, lineWidth: 3)
            )
            .padding(.vertical, 5)
            
            
            List {
                ForEach(alarmList) { alarm in
                    HStack{
                        Text(alarm.day)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 20)
                        Spacer()
                        Text("\(alarm.hour):\(alarm.minute)")
                            .fontWeight(.bold)
                            .padding(10)
                            .font(.system(size:22))
                    }
                }
            }
            .navigationTitle("Actual alarms")
        }
    }
    
    func addHour() {
        if self.hour != "" && self.hour.isInt {
            if self.hour == "23" {
                self.hour = "0"
            } else {
                self.hour = String((Int(self.hour)!) + 1)
            }
        } else {
            self.error = true
            self.errorMessage = "Hour should be number between 0 and 23"
        }
    }
    
    func substractHour() {
        if self.hour != "" && self.hour.isInt {
            if self.hour == "0" {
                self.hour = "23"
            } else {
                self.hour = String((Int(self.hour)!) - 1)
            }
        } else {
            self.error = true
            self.errorMessage = "Hour should be number between 0 and 23"
        }
    }
    
    func addMinute() {
        if self.minute != "" && self.minute.isInt {
            if self.minute == "59" {
                self.minute = "0"
            } else {
                self.minute = String((Int(self.minute)!) + 1)
            }
        } else {
            self.error = true
            self.errorMessage = "Minute should be number between 0 and 59"
        }
    }
    
    func substractMinute() {
        if self.minute != "" && self.minute.isInt {
            if self.minute == "0" {
                self.minute = "59"
            } else {
                self.minute = String((Int(self.minute)!) - 1)
            }
        } else {
            self.error = true
            self.errorMessage = "Minute should be number between 0 and 59"
        }
    }
    
    func addAlarm(){
        if self.day == "" {
            self.error = true
            self.errorMessage = "Fill day input"
            return
        }
        
        if !availableDays.contains(self.day){
            self.error = true
            self.errorMessage = "Inapropriate day name"
            return
        }
        
        for alarm in alarmList {
            if String(alarm.day) == self.day && String(alarm.hour) == self.hour && String(alarm.minute) == self.minute {
                self.error = true
                self.errorMessage = "Alarm for this day and time already exist"
                return
            }
        }
        
        if self.hour == "" || self.minute == "" {
            self.error = true
            self.errorMessage = "Fill hour and minute"
            return
        }
        
        if !self.hour.isInt || Int(self.hour)! > 23 || Int(self.hour)! < 0 {
            self.error = true
            self.errorMessage = "Hour should be number between 0 and 23"
            return
        }
        
        if !self.minute.isInt || Int(self.minute)! > 59 || Int(self.minute)! < 0 {
            self.error = true
            self.errorMessage = "Minute should be number between 0 and 59"
            return
        }
        
        let newAlarm = Alarm(day: self.day, hour: Int(self.hour)!, minute: Int(self.minute)!)
        
        print(newAlarm)
        alarmList.append(newAlarm)
        print(alarmList)
    }
    
}

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}

#Preview {
    AlarmView()
}
