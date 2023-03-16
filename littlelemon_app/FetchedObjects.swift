import CoreData
import Foundation
import SwiftUI

struct FetchedObjects<T, Content>: View where T : NSManagedObject, Content : View {
    
  let content: ([T]) -> Content

  var request: FetchRequest<T>
  var results: FetchedResults<T>{ request.wrappedValue }
    
  init(
    predicate: NSPredicate = NSPredicate(value: true),
    sortDescriptors: [NSSortDescriptor] = [],
    @ViewBuilder content: @escaping ([T]) -> Content
  ) {
    self.content = content
    self.request = FetchRequest(
      entity: T.entity(),
      sortDescriptors: Menu().buildSortDescriptors(),
      predicate: Menu().buildPredicate()
    )
  }
  
  
  var body: some View {
    self.content(results.map { $0 })
  }
  
  
}
