//
//  loginView.swift
//  zad05-OAuth
//
//  Created by Daniel_UJ on 04/01/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var login: String = ""
    @State private var password: String = ""
    @State private var responseError: Bool = false
    @State private var errorMessage: String = ""
    @State private var loginError: Bool = true
    @State private var passwordError: Bool = true
    @State private var buttonClicked: Bool = false
    @State private var navigateToUserPage: Bool = false
    @State private var user: User = User(name: "", age: 0, city: "")
    private var baseServerUrl = "https://9462-2a02-a31a-e045-4880-4979-db36-7b01-4532.ngrok-free.app"
    
    var body: some View{
        NavigationView{
            VStack{
                Text("Login to App")
                    .font(.title)
                    .padding()
                    .foregroundColor(.blue)
                
                TextField("Login", text: $login)
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
                    .padding(.vertical, 10)
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
                    .padding(.vertical, 10)
                    .alert(isPresented: $passwordError){
                        Alert(title: Text("ERROR"), message: Text("Fill password"), dismissButton: .default(Text("OK")))
                    }
                    .onDisappear{
                        passwordError = false
                    }
                
                Button(action: {
                    signIn()
                }, label: {
                    Text("Sign in")
                    .foregroundColor(.white)
                    .frame(width: 150, height: 50, alignment: .center)
                    .fontWeight(.bold)
                })
                .background(Color(.systemBlue))
                .cornerRadius(15)
                
                NavigationLink(destination: UserPageView(user: self.user), isActive: $navigateToUserPage){
                    EmptyView()
                }
            }
            .alert(isPresented: $responseError){
                Alert(title: Text("ERROR"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            .onDisappear{
                errorMessage = ""
                responseError = false
            }
        }
    }
    
    func signIn() {
        print("password: '\(password)', login: '\(login)'")
        
        if password == "" {
            passwordError = true
            print("empty password")
            return
        }

        if login == "" {
            loginError = true
            print("empty login")
            return
        }
        
        // create JSON data
        let loginData: [String: Any] = [
            "login": login,
            "password": password
        ]
                
        // create request
        var request = URLRequest(url: URL(string: "\(baseServerUrl)/login")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: loginData)
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
                return
            } else if  httpResponse.statusCode == 404 {
                self.errorMessage = "User not found"
                self.responseError = true
                return
            } else if httpResponse.statusCode == 409 {
                self.errorMessage = "Inappropriate password"
                self.responseError = true
                return
            }
            
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                self.user.name = user.name
                self.user.age = user.age
                self.navigateToUserPage = true
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}

#Preview {
    LoginView()
}
