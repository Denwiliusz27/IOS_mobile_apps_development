//
//  AlertView.swift
//  Tests
//
//  Created by Daniel_UJ on 27/01/2024.
//

import SwiftUI

struct AlarmView: View {    
    @State private var alarmFunctions = AlarmFunctions()
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
                                    (self.error, self.errorMessage, self.hour) = alarmFunctions.addHour(hour: self.hour)
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
                                    (self.error, self.errorMessage, self.hour) = alarmFunctions.substractHour(hour: self.hour)
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
                                    (self.error, self.errorMessage, self.minute) = alarmFunctions.addMinute(minute: self.minute)
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
                                    (self.error, self.errorMessage, self.minute) = alarmFunctions.substractMinute(minute: self.minute)
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
                    (self.error, alarmList, self.errorMessage) = alarmFunctions.addAlarm(availableDays: availableDays, alarmList: alarmList, day: self.day, hour: self.hour, minute: self.minute)
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
    
    
    
}

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}

#Preview {
    AlarmView()
}
