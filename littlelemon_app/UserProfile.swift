//
//  UserProfile.swift
//  littlelemon_app
//
//  Created by amruta on 13/03/23.
//

import SwiftUI

struct UserProfile: View {
  var name: String {
    guard let name = UserDefaults.standard.string(forKey: firstNameKey) else { return "Invalid firstName"}
    return name }
  var last: String {
    guard let lastName = UserDefaults.standard.string(forKey: lastNameKey) else { return "Inavalid lastName"}
    return lastName
  }
  var email: String {
    guard let mailId = UserDefaults.standard.string(forKey: emailKey) else { return "Inavalid MailId"}
    return mailId
  }
  @Environment(\.presentationMode) var presentation
    var body: some View {
      VStack {
        Text("Personal information")
          .font(.title)
          .bold()
        Image("Profile")
        Spacer().frame(height: 30)
        Text(name + " " + last)
          .font(.title3)
          .bold()
        Spacer().frame(height: 10)
        Text(email)
          .font(.callout)
        Spacer().frame(height: 40)
        
        Button {
          UserDefaults.standard.set(false, forKey: isLoggedInKey)
          self.presentation.wrappedValue.dismiss()
        } label: {
          Text("Logout")
            .font(.title3)
            .padding(10)
            .foregroundColor(Color.black)
            .background(Color.white)
            .cornerRadius(10)
        }
      }
     
      .padding()
      .background(Color.yellow)
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
