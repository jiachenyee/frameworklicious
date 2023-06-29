//
//  Case2View.swift
//  Demo Project
//
//  Created by Gerson Janhuel on 25/06/23.
//

import SwiftUI

struct Case2View: View {
    @EnvironmentObject var hapticsManager: HapticsManager
    
    var body: some View {
        Group {
            
            ZStack {
                
                HapticBounceView()
                    .ignoresSafeArea(.all)
                
            }
        }
        .navigationTitle("Physical Contact")
        
    }
}


struct HapticBounceView: UIViewControllerRepresentable {
    typealias UIViewControllerType = HapticBounceViewController
    
    func makeUIViewController(context: Context) -> HapticBounceViewController {
        let vc = HapticBounceViewController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: HapticBounceViewController, context: Context) {
        
    }
    
    
}
