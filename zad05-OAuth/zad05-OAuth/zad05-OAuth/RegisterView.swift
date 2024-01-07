//
//  RegisterView.swift
//  zad05-OAuth
//
//  Created by Daniel_UJ on 04/01/2024.
//

import SwiftUI

struct RegisterView: View {
    @State private var login: String = ""
    @State private var password: String = ""
    @State private var name: String = ""
    @State private var age: Int = 0
    @State private var city: String = ""
    
    @State private var responseError: Bool = false
    @State private var errorMessage: String = ""
    
    @State private var loginError: Bool = false
    @State private var passwordError: Bool = false
    @State private var nameError: Bool = false
    @State private var ageError: Bool = false
    @State private var cityError: Bool = false
    
    @State private var buttonClicked: Bool = false
    @State private var navigateToUserPage: Bool = false
    @State private var user: User = User(name: "", age: 0, city: "")
    
    private var baseServerUrl = "https://3c15-2a00-f41-58d0-a08b-f4ef-21bb-7392-e4d7.ngrok-free.app"
    
    init(){
        login  = ""
        password = ""
        name = ""
        age = 0
        city = ""
    }
    
    var body: some View{
        NavigationView{
            VStack{
                Text("Create new account")
                    .font(.title)
                    .padding()
                    .foregroundColor(.blue)
                
                TextInput(inputName: "Name", value: $name)
                    .alert(isPresented: $nameError){
                        Alert(title: Text("ERROR"), message: Text("Fill name"), dismissButton: .default(Text("OK")))
                    }
                    .onDisappear{
                        nameError = false
                    }
                
                Stepper("Age: \(age)", value: $age, in: 0...120, step: 1)
                    .frame(width: 260, height: 60, alignment: .center)
                    .padding(.horizontal, 20)
                    .background(Color.white)
                    .foregroundColor(.blue)
                    .cornerRadius(15)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.blue, lineWidth: 3)
                    )
                    .padding(.vertical, 5)
                    .alert(isPresented: $ageError){
                        Alert(title: Text("ERROR"), message: Text("Fill age"), dismissButton: .default(Text("OK")))
                    }
                    .onDisappear{
                        ageError = false
                    }
                
                TextInput(inputName: "City", value: $city)
                    .alert(isPresented: $cityError){
                        Alert(title: Text("ERROR"), message: Text("Fill city"), dismissButton: .default(Text("OK")))
                    }
                    .onDisappear{
                        cityError = false
                    }
                
                TextInput(inputName: "Login", value: $login)
                    .alert(isPresented: $loginError){
                        Alert(title: Text("ERROR"), message: Text("Fill login"), dismissButton: .default(Text("OK")))
                    }
                    .onDisappear{
                        loginError = false
                    }
                
                SecureField("Password", text: $password)
                    .frame(width: 260, height: 60, alignment: .center)
                    .padding(.horizontal, 20)
                    .background(Color.white)
                    .foregroundColor(.blue)
                    .cornerRadius(15)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.blue, lineWidth: 3)
                    )
                    .padding(.vertical, 5)
                    .alert(isPresented: $passwordError){
                        Alert(title: Text("ERROR"), message: Text("Fill password"), dismissButton: .default(Text("OK")))
                    }
                    .onDisappear{
                        passwordError = false
                    }
                
                Button(action: {
                    createAccount()
                }, label: {
                    Text("Create acconunt")
                    .foregroundColor(.white)
                    .frame(width: 180, height: 50, alignment: .center)
                    .fontWeight(.bold)
                })
                .background(Color(.systemBlue))
                .cornerRadius(15)
                .alert(isPresented: $responseError){
                    Alert(title: Text("ERROR"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
                .onDisappear{
                    errorMessage = ""
                    responseError = false
                }
                
                NavigationLink(destination: UserPageView(user: self.user), isActive: $navigateToUserPage){
                    EmptyView()
                }
            }
        }
    }
    
    func createAccount() {
        if name == "" {
            nameError = true
            return
        }
        
        if age == 0 {
            ageError = true
            return
        }
        
        if city == "" {
            cityError = true
            return
        }
        
        if login == "" {
            loginError = true
            return
        }
        
        if password == ""{
            passwordError = true
            return
        }
        
        // create JSON data
        let registerData: [String: Any] = [
            "name": name,
            "age": age,
            "city": city,
            "login": login,
            "password": password
        ]
                
        // create request
        var request = URLRequest(url: URL(string: "\(baseServerUrl)/register")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: registerData)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }

            if httpResponse.statusCode == 400 {
                self.errorMessage = "Error with server"
                self.responseError = true
            } else if httpResponse.statusCode == 409 {
                self.errorMessage = "User with this login already exist"
                self.responseError = true
            }
            
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                self.user.name = user.name
                self.user.age = user.age
                self.user.city = user.city
                self.navigateToUserPage = true
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}

#Preview {
    RegisterView()
}
