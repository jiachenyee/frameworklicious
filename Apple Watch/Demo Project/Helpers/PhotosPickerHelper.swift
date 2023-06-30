//
//  PhotosPickerHelper.swift
//  Connectivity210623
//
//  Created by Afina R. Vinci on 29/06/23.
//

import Foundation
import SwiftUI
import PhotosUI

extension PhotosPickerItem {
    func convert() async -> Image {
        do {
            if let image = try await self.loadTransferable(type: Image.self) {
                return image
            } else {
                return Image(systemName: "xmark.octagon")
            }
        } catch {
            print(error.localizedDescription)
            return Image(systemName: "xmark.octagon")
        }
    }
    
    func convertToData() async -> Data {
        do {
            if let imageData = try await self.loadTransferable(type: Data.self) {
                let uiimg = UIImage(data: imageData)
                if let compressed = uiimg?.jpegData(compressionQuality: 0.1) {
                    print("i'ts compressed")
                    return compressed
                } else {
                    print("not compressed")
                    return imageData
                }
            } else {
                return Data(count: 0)
            }
        } catch {
            print(error.localizedDescription)
            return Data(count: 0)
        }
    }
}
