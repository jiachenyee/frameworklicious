//
//  ShoppingView.swift
//  Connectivity210623 Watch App
//
//  Created by Afina R. Vinci on 29/06/23.
//

import SwiftUI

struct ShoppingView: View {
    @StateObject var connectivity: Connectivity = Connectivity()
    @State private var index = 0
    
    var body: some View {
        VStack {
//            Text("\(index)")
            if getShoppingItems().count > 0 {
                if index < getShoppingItems().count {
                    getImage(from: getShoppingItems()[index].imageData)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Text("\(getShoppingItems()[index].name)")
                    Button {
                        markAdded()
                            index += 1
                    } label: {
                        ZStack {
                            Capsule()
                                .fill(
                                    LinearGradient(colors: [.deepGreen, .darkGreen], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: 150, height: 40)
                            Text("Add to Cart")
                                .fontWeight(.medium)
                        }
                    }
                    
                } else {
                    Text("Shopping finished!")
                }
                
            } else {
                Text("Nothing to shop!")
            }
        }
    }
    
    func getShoppingItems() -> [ItemDataWatch] {
        var untakenItems: [ItemDataWatch] = []
        for item in connectivity.shoppingItems {
            if item.isTaken {
                
            } else {
                untakenItems.append(item)
            }
        }
        return untakenItems
    }
    
    func getImage(from data: Data) -> Image {
        if let uiimg = UIImage(data: data) {
            return Image(uiImage: uiimg)
        } else {
            return Image(systemName: "xmark.octagon")
        }
    }
    
    func markAdded() {
        let data = ["updatedItemName": getShoppingItems()[index].name]
        connectivity.transferUserInfo(data)
    }
}

struct ShoppingView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingView()
    }
}
