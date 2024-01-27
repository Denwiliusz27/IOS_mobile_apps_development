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
        Alarm( day: "Monday", hour: 6, minute: 55),
    ]
    
    var body: some View{
        VStack {
            Text("Alarms")
                .font(.title)
                .fontWeight(.bold)
                .padding(15)
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
                        .padding(.horizontal, 20)
                }
                .alert(isPresented: $error) {
                    Alert(title: Text("ERROR"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
            
                
            }
            .frame(width: 260, alignment: .center)
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
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
                        Spacer()
                        Text("\(alarm.hour) : \(alarm.minute)")
                            .fontWeight(.bold)
                    }
                    
                }
            }
            .navigationTitle("Actual alarms")
        }
    }
    
    func addHour() {
        if self.hour != "" {
            self.hour = String((Int(self.hour) ?? 0) + 1)
        }
    }
    
    func substractHour() {
        if self.hour != "" {
            self.hour = String((Int(self.hour) ?? 0) - 1)
        }
    }
    
    func addMinute() {
        if self.minute != "" {
            self.minute = String((Int(self.minute) ?? 0) + 1)
        }
    }
    
    func substractMinute() {
        if self.minute != "" {
            self.minute = String((Int(self.minute) ?? 0) - 1)
        }
    }
    
    func addAlarm(){
        if !availableDays.contains(self.day){
            self.error = true
            self.errorMessage = "Inapropriate day name"
        }
        
        if self.day == "" {
            self.error = true
            self.errorMessage = "Fill day input"
        }
        
        if self.hour == "0" || self.minute == "0" {
            self.error = true
            self.errorMessage = "Fill hour and minute"
        }
        
        if Int(self.hour) ?? 0 > 23 || Int(self.hour) ?? 0 < 0 || !self.hour.isInt{
            self.error = true
            self.errorMessage = "Hour should be number between 0 and 23"
        }
        
        if Int(self.minute) ?? 0 > 59 || Int(self.minute) ?? 0 < 0 || !self.minute.isInt{
            self.error = true
            self.errorMessage = "Minute should be number between 0 and 23"
        }
        
        
        let newAlarm = Alarm(day: self.day, hour: Int(self.hour) ?? 0, minute: Int(self.minute) ?? 0)
        
        
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
