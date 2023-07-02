//
//  ShareSheetViewRepresentable.swift
//  PencilKitDemo290623
//
//  Created by Afina R. Vinci on 02/07/23.
//

import SwiftUI

struct ShareSheetViewRepresentable: UIViewControllerRepresentable {
    typealias Callback = (
        _ activityType: UIActivity.ActivityType?,
        _ completed: Bool,
        _ returnedItems: [Any]?,
        _ error: Error?) -> Void
    
    var activityItems: [Any]
    var applicationActivities: [UIActivity]?
    var excludedActivityTypes: [UIActivity.ActivityType]?
    var callback: Callback?
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
    }
}

