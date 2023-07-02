//
//  ListView.swift
//  Connectivity210623
//
//  Created by Afina R. Vinci on 29/06/23.
//

import SwiftUI
import CoreData

struct ListView: View {
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.createdDate)
    ]) var shoppingItems: FetchedResults<ItemData>
    @State private var isShowingSheet = false
    @Environment(\.managedObjectContext) var moc
    @StateObject var connectivity = Connectivity()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(shoppingItems) { item in
                        HStack {
                            getImageFromCoreData(item)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            VStack(alignment: .leading) {
                                Text(item.name ?? "")
                                    .font(.title3)
                                    .fontWeight(.medium)
                                Text(String(format: "%.1f", item.quantity) + " \(item.quantityType!)")
                            }.padding(.leading, 20)
                        }.listRowBackground(LinearGradient(colors: item.isTaken ? [.darkGreen, .deepGreen] : [.darkGray, .deepGray], startPoint: .topLeading, endPoint: .bottomTrailing))
                    }
                    .onDelete(perform: removeItem(at:))
                }
                Button("Send Shopping List") {
                    sendShoppingList()
                }.buttonStyle(.borderedProminent)
            }
            .navigationTitle("Shopping List")
            .toolbar {
                Button {
                    isShowingSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .padding()
        .sheet(isPresented: $isShowingSheet) { AddItemView(isShowingSheet: $isShowingSheet)
        }
        .onChange(of: connectivity.updatedItemName, perform: { name in
            let fetchRequest: NSFetchRequest<ItemData> = ItemData.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name == %@", name)
            
            do {
                let fetchedItems = try moc.fetch(fetchRequest)
                if let item = fetchedItems.first {
                    item.isTaken = true
                    try moc.save()
                }
            } catch {
                // Handle the error if fetching or saving fails
            }
        })
    }
    
    func sendShoppingList() {
        for item in shoppingItems {
            if !item.isTaken {
                connectivity.sendMessage(convertToDictionary(object: item))
            }
        }
    }
    
    func removeItem(at offsets: IndexSet) {
        for index in offsets {
            let item = shoppingItems[index]
            moc.delete(item)
        }
        do {
            try moc.save()
        } catch {
            // handle the Core Data error
        }
    }
    
    func getImageFromCoreData(_ item: FetchedResults<ItemData>.Element) -> Image {
        if let data = item.imageData, let uiimg = UIImage(data: data) {
            return Image(uiImage: uiimg)
        } else {
            return Image(systemName: "photo")
        }
    }
    
    func convertToDictionary(object: NSManagedObject) -> [String: Any] {
        var dictionary: [String: Any] = [:]
        
        for attribute in object.entity.attributesByName {
            if let value = object.value(forKey: attribute.key) {
                dictionary[attribute.key] = value
            }
        }
        return dictionary
    }

}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
