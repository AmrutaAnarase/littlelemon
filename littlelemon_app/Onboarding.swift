//
//  Onboarding.swift
//  littlelemon_app
//
//  Created by amruta on 13/03/23.
//

import SwiftUI
let firstNameKey = "first_name_key"
let lastNameKey = "last_name_key"
let emailKey = "email_key"
let isLoggedInKey = "isLoggedIn_key"

struct Onboarding: View {
  @State var firstName = ""
  @State var lastName = ""
  @State var email = ""
  @State var isLoggedIn = false
  @State private var showingAlert = false
  var body: some View {
    NavigationView {
      VStack {
        NavigationLink(destination: Home(), isActive: $isLoggedIn) {
          EmptyView()
        }
        Image("Logo")
          .resizable()
          .padding(10)
          .frame(width: 200, height: 100)
        VStack(alignment: .leading) {
          Text("First Name")
          
          TextField("First Name: ", text: $firstName)
            .padding()
            .border(.black)
            .background(Color.yellow)
          Text("Last Name")
          TextField("Last Name: ", text: $lastName)
            .padding()
            .border(.black)
            .background(Color.yellow)
          Text("EmailID")
          TextField("Email Address: ", text: $email)
            .padding()
            .border(.black)
            .background(Color.yellow)
        }
        Spacer().frame(height: 30)
        Button {
          if firstName.isEmpty && lastName.isEmpty && email.isEmpty {
           showingAlert = true
          } else {
            UserDefaults.standard.set(firstName, forKey: firstNameKey)
            UserDefaults.standard.set(lastName, forKey: lastNameKey)
            UserDefaults.standard.set(email, forKey: emailKey)
            UserDefaults.standard.set(isLoggedIn, forKey: isLoggedInKey)
            isLoggedIn = true
          }
        } label: {
          Text("Register")
            .padding(10)
            .foregroundColor(.black)
            .background(.yellow)
            .cornerRadius(10)
        }
        .alert("Please enter valid information", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
      }
      .padding()
      .border(.brown)
      .navigationTitle("Little Lemon")
      .onAppear {
        if UserDefaults.standard.bool(forKey: isLoggedInKey) {
          isLoggedIn = true
        }
      }
    }
  }
}

struct Onboarding_Previews: PreviewProvider {
  static var previews: some View {
    Onboarding()
  }
}
