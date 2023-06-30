//
//  AddItemView.swift
//  Connectivity210623
//
//  Created by Afina R. Vinci on 29/06/23.
//

import SwiftUI
import PhotosUI

struct AddItemView: View {
    @State private var itemName: String = ""
    @State private var quantity: String = ""
    @State private var unit: String = "pcs"
    @State private var photo: PhotosPickerItem?
    @State private var selectedImage: Image?
    @State private var imageData: Data? = .init(count: 0)
    @Binding var isShowingSheet: Bool
    var unitSelection = ["pcs", "gram", "liter"]
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationView {
            VStack {
                if let selectedImage {
                    selectedImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .frame(width: 100)
                }
                PhotosPicker(selection: $photo, matching: .images) {
                    Text("Select a Photo")
                }
                Form {
                    TextField("Item Name", text: $itemName)
                    TextField("Item Quantity", text: $quantity)
                        .keyboardType(.numberPad)
                    Picker("Quantity Unit", selection: $unit) {
                        ForEach(unitSelection, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                }
                Button("Add New Item") {
                    addItem()
                }
                .buttonStyle(.borderedProminent)
                .font(.title2)
                .fontWeight(.bold)
                Spacer()
            }
            .navigationBarTitleDisplayMode(.automatic)
            .navigationTitle("New Item")
            .onChange(of: photo) { newPhoto in
                Task {
                    selectedImage = await newPhoto?.convert()
                    imageData = await newPhoto?.convertToData()
                }
            }
        }
    }
    
    func addItem() {
        let item = ItemData(context: moc)
        item.name = itemName
        item.quantity = Double(quantity) ?? 0.0
        item.quantityType = unit
        item.isTaken = false
        item.imageData = imageData
        item.createdDate = Date()
        try? moc.save()
        isShowingSheet = false
    }
    
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(isShowingSheet: .constant(true))
    }
}
