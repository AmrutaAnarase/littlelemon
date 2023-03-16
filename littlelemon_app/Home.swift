//
//  Home.swift
//  littlelemon_app
//
//  Created by amruta on 13/03/23.
//

import SwiftUI

struct Home: View {
  let menu = Menu()
  let userProfiles = UserProfile()
  let persistence = PersistenceController()
  var body: some View {
    TabView {
      menu
        .font(.title)
        .tabItem {
          Label("Menu", systemImage: "list.dash")
        }
        .environment(\.managedObjectContext, persistence.container.viewContext)
      userProfiles
        .font(.title)
        .tabItem {
          Label("Profile", systemImage: "square.and.pencil")
        }
        .navigationBarBackButtonHidden(true)
    }
  }
}

struct Home_Previews: PreviewProvider {
  static var previews: some View {
    Home()
  }
}
