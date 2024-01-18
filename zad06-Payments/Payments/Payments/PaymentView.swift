//
//  PaymentView.swift
//  Payments
//
//  Created by Daniel_UJ on 17/01/2024.
//

import SwiftUI

struct PaymentView: View {
    @State private var cardNr: String = ""
    @State private var cardError: Bool = false
    @State private var ccv: String = ""
    @State private var ccvError: Bool = false
    @State private var responseError: Bool = false
    @State private var errorMessage: String = ""
    @State private var navigateToConfirmPage: Bool = false
    private var baseServerUrl = "test"
    
    let product: Product
    
    init(product: Product) { // Dostosuj dostęp do inicjalizatora
            self.product = product
        }
    
    var body: some View {
        NavigationView{
                    VStack{
                        VStack{
                            Text("You're buying:")
                                .font(.title)
                                .padding()
                            
                            HStack{
                                Text("Product")
                                    .bold()
                                    .padding(.leading)
                                Spacer()
                                
                                Text("Price")
                                    .bold()
                                    .padding(.trailing)
                            }
                            
                            HStack{
                                Text(product.name!)
                                    .bold()
                                    .padding(.leading)
                                Spacer()
                                
                                Text(String(format: "%.2f", product.price))
                            }
                        }
                        .padding(30)
                        
                        
                        Text("Provide card data")
                            .font(.title)
                            .padding()
                            .foregroundColor(.blue)
                        
                        TextField("Card number", text: $cardNr)
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
                            .alert(isPresented: $cardError){
                                return Alert(title: Text("ERROR"), message: Text("Fill card number"), dismissButton: .default(Text("OK")))
                            }
                            .onDisappear{
                                cardError = false
                            }
                        
                        SecureField("Ccv number", text: $ccv)
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
                            .alert(isPresented: $ccvError){
                                return Alert(title: Text("ERROR"), message: Text("Fill ccv number"), dismissButton: .default(Text("OK")))
                            }
                            .onDisappear{
                                ccvError = false
                            }
                        
                        Button(action: {
                            pay()
                        }, label: {
                            Text("pay")
                            .foregroundColor(.white)
                            .frame(width: 150, height: 50, alignment: .center)
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
                        
                        NavigationLink(destination: ConfirmPage(product: product), isActive: $navigateToConfirmPage){
                            EmptyView()
                        }
                    }
                    
                }
            }
            
            func pay() {
                if cardNr == "" {
                    cardError = true
                    return
                }
                
                if ccv == "" {
                    ccvError = true
                    return
                }
                
                // create JSON data
                let cardData: [String: Any] = [
                    "number": cardNr,
                    "ccv": ccv,
                    "product": product.name!
                ]
                        
                // create request
                var request = URLRequest(url: URL(string: "\(baseServerUrl)/buy")!)
                request.httpMethod = "POST"
                request.httpBody = try? JSONSerialization.data(withJSONObject: cardData)
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
                        self.errorMessage = "Card not found"
                        self.responseError = true
                        return
                    } else if httpResponse.statusCode == 409 {
                        self.errorMessage = "Inappropriate ccv"
                        self.responseError = true
                        return
                    }
                    
//                    do {
//                        let user = try JSONDecoder().decode(User.self, from: data)
//                        self.user.name = user.name
//                        self.user.age = user.age
//                        self.user.city = user.city
                    self.navigateToConfirmPage = true
//
//                    } catch {
//                        print(error)
//                    }
                }
                task.resume()
            }
        }

