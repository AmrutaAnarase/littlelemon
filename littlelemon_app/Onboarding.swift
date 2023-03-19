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
let phoneNumberKey = "phone_number_key"

struct Onboarding: View {
  @State var firstName = ""
  @State var lastName = ""
  @State var email = ""
  @State var isLoggedIn = false
  @State private var showingAlert = false
  @State private var errorMessage = ""
  var body: some View {
    NavigationView {
      VStack {
        NavigationLink(destination: Home(), isActive: $isLoggedIn) {
          EmptyView()
        }
        Image("Logo")
        
        VStack(alignment: .leading){
          Text("Little Lemon")
            .font(.system(size: 48))
            .bold()
            .foregroundColor(CustomColor.littleLemonYellow)
            .padding([.bottom], 10)
          HStack{
            VStack(alignment: .leading){
              Text("Chicago")
                .font(.system(size: 30))
                .foregroundColor(.white)
                .bold()
                .padding([.bottom], 30)
              Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                .font(.callout)
                .foregroundColor(.white)
            }
            Image("Hero_image")
              .resizable()
              .frame(width: 160, height: 170)
              .cornerRadius(10)
          }
          .padding([.bottom], 30)
        }
        .padding([.leading, .trailing])
        .background(CustomColor.littleLemonDarkGreen)
        VStack(alignment: .leading) {
          Text("First Name *")
          
          TextField("Enter your First Name: ", text: $firstName)
            .padding()
            .border(.black)
            .frame(height: 52)
            .cornerRadius(5)
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
          Text("Last Name *")
          TextField("Enter your Last Name: ", text: $lastName)
            .padding()
            .border(.black)
            .frame(height: 52)
            .cornerRadius(5)
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
          Text("EmailID *")
          TextField("Enter your Email Address: ", text: $email)
            .padding()
            .border(.black)
            .frame(height: 52)
            .cornerRadius(5)
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
        }
        Spacer().frame(height: 30)
        Button {
          if !validateForm(){
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
            .font(.title)
            .foregroundColor(CustomColor.littleLemonDarkGreen)
            .padding()
            .frame(width: 300, height: 56)
            .background(CustomColor.littleLemonYellow)
            .cornerRadius(12)
        }
        .alert("Please enter valid information", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
      }
      .padding()
      .border(.brown)
      .onAppear {
        if UserDefaults.standard.bool(forKey: isLoggedInKey) {
          isLoggedIn = true
        }
      }
    }
  }
  
  private func validateForm() -> Bool {
      let firstNameIsValid = isValid(name: firstName)
      let lastNameIsValid = isValid(name: lastName)
      let emailIsValid = isValid(email: email)
      
      guard firstNameIsValid && lastNameIsValid && emailIsValid
      else {
          var invalidFirstNameMessage = ""
          if firstName.isEmpty || !isValid(name: firstName) {
              invalidFirstNameMessage = "First name can only contain letters and must have at least 1 characters\n\n"
          }
          
          var invalidLastNameMessage = ""
          if lastName.isEmpty || !isValid(name: lastName) {
              invalidLastNameMessage = "Last name can only contain letters and must have at least 1 characters\n\n"
          }
          
          
          var invalidEmailMessage = ""
          if email.isEmpty || !isValid(email: email) {
              invalidEmailMessage = "The e-mail is invalid and cannot be blank."
          }
          
          self.errorMessage = "Found these errors in the form:\n\n \(invalidFirstNameMessage)\(invalidLastNameMessage)\(invalidEmailMessage)"
          
          return false
      }
      return true
  }
  func isValid(name: String) -> Bool {
      guard !name.isEmpty,
            name.count > 0
      else { return false }
      for chr in name {
          if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") && !(chr == " ") ) {
              return false
          }
      }
      return true
  }

  func isValid(email:String) -> Bool {
      guard !email.isEmpty else { return false }
      let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
      let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
      return emailValidationPredicate.evaluate(with: email)
  }

}

struct Onboarding_Previews: PreviewProvider {
  static var previews: some View {
    Onboarding()
  }
}
