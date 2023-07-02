//
//  PKCanvasViewRepresentable.swift
//  PencilKitDemo290623
//
//  Created by Afina R. Vinci on 02/07/23.
//

import SwiftUI
import PencilKit

struct PKCanvasViewRepresentable : UIViewRepresentable {
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, PKCanvasViewDelegate {
        
        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {

        }

    }
    
    @Binding var canvasView: PKCanvasView
    @State var toolPicker = PKToolPicker()
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .pencilOnly
        canvasView.backgroundColor = .clear
        canvasView.isOpaque = false

        toolPicker.colorUserInterfaceStyle = .light
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.selectedTool = PKInkingTool(.pen, color: .black, width: 15)
        toolPicker.addObserver(canvasView)
        
        canvasView.becomeFirstResponder()
        canvasView.delegate = context.coordinator
        
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
    }
}

