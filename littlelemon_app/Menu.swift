//
//  Menu.swift
//  littlelemon_app
//
//  Created by amruta on 13/03/23.
//

import SwiftUI

struct Menu: View {
  
  @Environment(\.managedObjectContext) private var viewContext
  @State var searchText = ""
  var body: some View {
    VStack {
      Text("Little Lemon")
        .font(.title)
        .bold()
      Text("Chicago")
        .font(.title3)
      Text("Order food and get quick doorstep deliveries")
        .font(.callout)
      
      FetchedObjects{ (dishes: [Dish]) in
        
        List {
          TextField("Search menu", text: $searchText)
            .font(.caption)
            .padding(30)
            .frame(height: 20)
            .foregroundColor(.black)
            .background(Color.white)
            .cornerRadius(10)
          
          ForEach(dishes, id: \.self) { singleItem in
            HStack {
              Text((singleItem.title ?? "title") + ": " + (singleItem.price ?? "100"))
              let imageURL:String = singleItem.image ?? "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/grilledFish.jpg?raw=true"
              Spacer()
              AsyncImage(url: URL(string: imageURL))
              { img in
                img.resizable()
              } placeholder: {
                ProgressView()
              }
              .frame(width: 30, height: 30)
            }
          }
        }
      }
      
    }
    .background(Color.yellow)
    .onAppear{
      getMenuData()
    }
  }
}

struct Menu_Previews: PreviewProvider {
  static var previews: some View {
    Menu()
  }
}

extension Menu {
  func getMenuData() {
    PersistenceController.shared.clear()
    let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
    let request = URLRequest(url: url)
    let downloadTask = URLSession(configuration: .default).dataTask(with: request) { (data, response, error) in
      if let data = data {
        let decoder = JSONDecoder()
        let parsedData = try! decoder.decode(MenuList.self, from: data)
        print("parsedData\(parsedData)")
        parsedData.menu.forEach { menuItem in
          let dish = Dish(context: viewContext)
          dish.title = menuItem.title
          dish.price = menuItem.price
          dish.image = menuItem.image
          dish.category = menuItem.category
        }
        try? viewContext.save()
        
      }
    }
    downloadTask.resume()
  }
  func buildSortDescriptors() -> [NSSortDescriptor] {
    return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
  }
  func buildPredicate() -> NSPredicate {
    if searchText.isEmpty {
      return NSPredicate(value: true)
    } else {
      return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
  }
}
