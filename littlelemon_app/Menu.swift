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
      VStack(alignment: .leading){
        Text("Little Lemon")
          .font(.system(size: 48))
          .bold()
          .foregroundColor(CustomColor.littleLemonYellow)
          .padding([.bottom], 10)
        HStack(alignment: .top){
          VStack(alignment: .leading){
            Text("Chicago")
              .font(.system(size: 30))
              .foregroundColor(.white)
              .bold()
              .padding([.bottom], 30)
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
              .font(.callout)
              .foregroundColor(.white)
              .frame(width: 200 , height: 160)
            
          }
          Image("Hero_image")
            .resizable()
            .frame(width: 160, height: 170)
            .cornerRadius(10)
        }
        .padding([.bottom], 30)
        
        ZStack(alignment: Alignment.leading) {
            Rectangle().frame(height: 76)
                .foregroundColor(CustomColor.littleLemonDarkGreen)
            TextField("", text: $searchText)
                .frame(height: 48)
                .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 6))
                
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                .background(Color.white)
                .cornerRadius(5)
                .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFill()
                .frame(width: 20, height: 20)
                .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0))
        }.padding(.top, -36)
        Rectangle().frame(height: 16)
            .foregroundColor(CustomColor.littleLemonDarkGreen)
            .padding(.top, -8)
      }
      FetchedObjects{ (dishes: [Dish]) in
        
        List {
        
          ForEach(dishes, id: \.self) { dish in
            MenuItemRowView (
                name: dish.title ?? "",
                description: dish.dishDescription ?? "",
                price: dish.price ?? "",
                imageUrl: dish.image ?? "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/grilledFish.jpg?raw=true"
            )
            Divider().padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
          }
        }
      }
      
    }
    .background(CustomColor.littleLemonDarkGreen)
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
          dish.dishDescription = menuItem.dishDescription
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

struct MenuItemRowView: View {
    let name: String
    let description: String
    let price: String
    let imageUrl: String
    
    var body: some View {
        HStack {
            VStack(alignment: HorizontalAlignment.leading) {
                Text(name)
                    .font(.system(size: 20))
                    .padding([.top, .bottom], 4)
                Text(description)
                    .lineLimit(2)
                    .font(.system(size: 16))
                    .foregroundColor(CustomColor.littleLemonDarkGreen)
                Text(formatPrice(priceStr: price))
                .padding([.top, .bottom], 4)
                    .font(.system(size: 20))
                    .foregroundColor(CustomColor.littleLemonDarkGreen)
            }
            .padding([.leading], 12)
          let imageURL:String = imageUrl
          Spacer()
          AsyncImage(url: URL(string: imageURL))
          { img in
            img.resizable()
          } placeholder: {
            ProgressView()
          }
          .frame(width: 60, height: 60)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 124)
    }
    
    private func formatPrice(priceStr: String) -> String {
        if let price = Float(priceStr) {
            let spacing = price < 10 ? " " : ""
            return "$ " + spacing + String(format: "%.2f", price)
        } else {
            return ""
        }
    }
}

