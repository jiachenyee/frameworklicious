//
//  File.swift
//  
//
//  Created by Jia Chen Yee on 10/06/23.
//

import Foundation

@available(iOS 16.0, *)
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
class FrameworkliciousViewModel: ObservableObject {
    @Published var isFrameworkPresented = false {
        didSet {
            lastInteractionDate = .now
        }
    }
    
    var timer: Timer?
    
    @Published var lastInteractionDate: Date = .now {
        didSet {
            guard isFrameworkPresented else { return }
            timer?.invalidate()
//            timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: false) { timer in
//                self.isFrameworkPresented = false
//            }
        }
    }
}
