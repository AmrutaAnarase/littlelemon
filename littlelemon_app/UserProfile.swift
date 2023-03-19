//
//  UserProfile.swift
//  littlelemon_app
//
//  Created by amruta on 13/03/23.
//

import SwiftUI

struct UserProfile: View {
//  var name: String {
//    guard let name = UserDefaults.standard.string(forKey: firstNameKey) else { return "Invalid firstName"}
//    return name }
//  var last: String {
//    guard let lastName = UserDefaults.standard.string(forKey: lastNameKey) else { return "Inavalid lastName"}
//    return lastName
//  }
//  var email: String {
//    guard let mailId = UserDefaults.standard.string(forKey: emailKey) else { return "Inavalid MailId"}
//    return mailId
//  }
//  var phoneNumber: String {
//    guard let mailId = UserDefaults.standard.string(forKey: phoneNumberKey) else { return "Inavalid MailId"}
//    return mailId
//  }

  let kOrderStatusNotification = "order status notification key"
  let kPasswordChangesNotification = "password changes notification key"
  let kSpecialOfferNotification = "special offer notification key"
  let kNewsLetterNotification = "news letter notification key"
  @Environment(\.presentationMode) var presentation
  
  @State private var name: String = ""
  @State private var last: String = ""
  @State private var email: String = ""
  @State private var phoneNumber: String = ""
  @State private var orderStatusNotification: Bool = false
  @State private var passwordChangesNotification: Bool = false
  @State private var specialOfferNotification: Bool = false
  @State private var newsLetterNotification: Bool = false
  
  var body: some View {
      NavigationView {
          VStack {
              toolbarSection
              
              ScrollView {
                  VStack {
                      avatarSection
                      textInputSection
                      notificationSection
                      bottomButtonsSection
                  }
              }
          }
      }.onAppear() {
          loadUserData()
      }
  }
  
  var toolbarSection: some View {
      ZStack {
          Image("Logo")
          HStack() {
              Spacer()
              NavigationLink(destination: UserProfile()) {
                  Image("Profile")
                      .resizable()
                      .scaledToFill()
                      .frame(width: 50, height: 50)
                      .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 24))
              }
          }
      }
  }
  
  var avatarSection: some View {
      VStack(alignment: HorizontalAlignment.leading) {
          Text("Personal information")
              .font(.system(size: 18, weight: .regular))
              .padding(EdgeInsets(top: 24, leading: 0, bottom: 8, trailing: 0))
          Text("Avatar").font(.system(size: 14, weight: .regular))
          HStack(alignment: VerticalAlignment.center) {
              Image("Profile")
                  .resizable()
                  .scaledToFill()
                  .frame(width: 100, height: 100)
                  .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
              ButtonWithFilledColor(
                  label: "Change",
                  backgroundColor: CustomColor.littleLemonDarkGreen,
                  textColor: Color.white,
                  cornerRadius: 8,
                  action: {})
              .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
              ButtonWithBorder(label: "Remove", action: {})
              Spacer()
          }
      }.padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
  }
  
  var textInputSection: some View {
      Group {
          TextFieldWithBorder(
              textLabel: "First name",
              textFieldLabel: "Enter your first name",
              textInput: $name)
          .padding(EdgeInsets(top: 12, leading: 24, bottom: 0, trailing: 24))
          TextFieldWithBorder(
              textLabel: "Last name",
              textFieldLabel: "Enter your last name",
              textInput: $last)
          .padding(EdgeInsets(top: 12, leading: 24, bottom: 0, trailing: 24))
          TextFieldWithBorder(
              textLabel: "Email",
              textFieldLabel: "Enter your email address",
              textInput: $email)
          .padding(EdgeInsets(top: 12, leading: 24, bottom: 0, trailing: 24))
          TextFieldWithBorder(
              textLabel: "Phone number",
              textFieldLabel: "Enter your phone number",
              textInput: $phoneNumber)
          .padding(EdgeInsets(top: 12, leading: 24, bottom: 0, trailing: 24))
      }
  }
  
  var notificationSection: some View {
      HStack {
          VStack(alignment: HorizontalAlignment.leading) {
              Text("Email Notification")
                  .font(.system(size: 18, weight: .regular))
                  .padding(EdgeInsets(top: 24, leading: 24, bottom: 0, trailing: 0))
              CheckboxWithLabel(isChecked: $orderStatusNotification, label: "Order status")
                  .padding(EdgeInsets(top: 4, leading: 24, bottom: 0, trailing: 24))
              CheckboxWithLabel(isChecked: $passwordChangesNotification, label: "Password changes")
                  .padding(EdgeInsets(top: 4, leading: 24, bottom: 0, trailing: 24))
              CheckboxWithLabel(isChecked: $specialOfferNotification, label: "Special offers")
                  .padding(EdgeInsets(top: 4, leading: 24, bottom: 0, trailing: 24))
              CheckboxWithLabel(isChecked: $newsLetterNotification, label: "Newsletter")
                  .padding(EdgeInsets(top: 4, leading: 24, bottom: 0, trailing: 24))
          }
          Spacer()
      }
  }
  
  var bottomButtonsSection: some View {
      Group {
          Button(action: {
              resetUserData()
              self.presentation.wrappedValue.dismiss()
          }) {
              Text("Log out")
                  .font(.system(size: 16, weight: .bold))
                  .foregroundColor(CustomColor.littleLemonDarkGreen)
                  .padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0))
                  .frame(maxWidth: .infinity)
                  .background(CustomColor.littleLemonYellow)
                  .cornerRadius(5)
              
          }
          .buttonStyle(PlainButtonStyle())
          .padding(EdgeInsets(top: 24, leading: 24, bottom: 48, trailing: 24))
          HStack {
              ButtonWithBorder(label: "Discard changes", action: {
                  loadUserData()
              })
              .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 24))
              ButtonWithFilledColor(
                  label: "Save changes",
                  backgroundColor: CustomColor.littleLemonDarkGreen,
                  textColor: Color.white,
                  cornerRadius: 8
              ) {
                  saveUserData()
              }
          }
      }
  }
  
  private func resetUserData() {
      let defaults = UserDefaults.standard
      defaults.set("", forKey: firstNameKey)
      defaults.set("", forKey: lastNameKey)
      defaults.set("", forKey: emailKey)
      defaults.set("", forKey: phoneNumberKey)
      
      defaults.set(false, forKey: kOrderStatusNotification)
      defaults.set(false, forKey: kPasswordChangesNotification)
      defaults.set(false, forKey: kSpecialOfferNotification)
      defaults.set(false, forKey: kNewsLetterNotification)
  }
  
  private func saveUserData() {
      let defaults = UserDefaults.standard
      defaults.set(name, forKey: firstNameKey)
      defaults.set(last, forKey: lastNameKey)
      defaults.set(email, forKey: emailKey)
      defaults.set(phoneNumber, forKey: phoneNumberKey)
      
      defaults.set(orderStatusNotification, forKey: kOrderStatusNotification)
      defaults.set(passwordChangesNotification, forKey: kPasswordChangesNotification)
      defaults.set(specialOfferNotification, forKey: kSpecialOfferNotification)
      defaults.set(newsLetterNotification, forKey: kNewsLetterNotification)
  }
  
  private func loadUserData() {
      let defaults = UserDefaults.standard
      let savedFirstName = defaults.string(forKey: firstNameKey) ?? ""
      let savedLastName = defaults.string(forKey: lastNameKey) ?? ""
      let savedEmail = defaults.string(forKey: emailKey) ?? ""
      let savedPhoneNumber = defaults.string(forKey: phoneNumberKey) ?? ""
      
      let savedOrderStatusNotification = defaults.bool(forKey: kOrderStatusNotification)
      let savedPasswordChangesNotification = defaults.bool(forKey: kPasswordChangesNotification)
      let savedSpecialOfferNotification = defaults.bool(forKey: kSpecialOfferNotification)
      let savedNewsLetterNotification = defaults.bool(forKey: kNewsLetterNotification)
      
      name = savedFirstName
      last = savedLastName
      email = savedEmail
    phoneNumber = savedPhoneNumber
      
      orderStatusNotification = savedOrderStatusNotification
      passwordChangesNotification = savedPasswordChangesNotification
      specialOfferNotification = savedSpecialOfferNotification
      newsLetterNotification = savedNewsLetterNotification
  }
  
  struct ButtonWithFilledColor: View {
      
      let label: String
      let backgroundColor: Color
      let textColor: Color
      let cornerRadius: CGFloat
      let action: () -> Void
      
      var body: some View {
          Button(action: action) {
              Text(label)
                  .font(.system(size: 16, weight: .bold))
                  .foregroundColor(textColor)
                  .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 12))
                  .background(backgroundColor)
                  .cornerRadius(cornerRadius)
          }
      }
  }

  struct TextFieldWithBorder: View {
      let textLabel: String
      let textFieldLabel: String
      let textInput: Binding<String>
      
      var body: some View {
          VStack(alignment: HorizontalAlignment.leading) {
              Text(textLabel).foregroundColor(CustomColor.littleLemonDarkGreen)
              TextField(textFieldLabel, text: textInput)
              // option 1:
              // .padding()
              // .textFieldStyle(PlainTextFieldStyle())
              // .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
              // option 2:
                  .frame(height: 52)
                  .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
                  .cornerRadius(5)
                  .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
          }
      }
  }
  struct ButtonWithBorder: View {
      let label: String
      let action: () -> Void
      
      let backgroundColor: Color = Color.white
      let textColor: Color = CustomColor.littleLemonDarkGreen
      let borderStrokeColor: Color = CustomColor.littleLemonDarkGreen
      let cornerRadius: CGFloat = 8
      let borderStrokeWidth: CGFloat = 2
      
      var body: some View {
          Button(action: action) {
              Text(label)
                  .font(.system(size: 16, weight: .bold))
                  .foregroundColor(textColor)
                  .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
                  .background(backgroundColor)
                  .overlay(
                      RoundedRectangle(cornerRadius: cornerRadius).stroke(borderStrokeColor, lineWidth: borderStrokeWidth))
          }
      }
  }
  struct CheckboxWithLabel: View {
      @Binding var isChecked: Bool
      let label: String
      
      var body: some View {
          Button(action: {
              self.isChecked = !self.isChecked
          }) {
              HStack(alignment: .center, spacing: 10) {
                  ZStack {
                      Rectangle()
                          .fill(self.isChecked ? CustomColor.littleLemonDarkGreen : Color.white)
                          .frame(width: 30, height: 30, alignment: .center)
                          .cornerRadius(5)
                          .overlay(
                              RoundedRectangle(cornerRadius: 5)
                                  .stroke(CustomColor.littleLemonDarkGreen, lineWidth: 1))
                      if isChecked {
                          Image(systemName: "checkmark")
                              .foregroundColor(Color.white)
                      }
                  }
                  Text(label).font(.system(size: 14, weight: .regular))
              }
          }
          .foregroundColor(Color.black)
      }
  }


}

