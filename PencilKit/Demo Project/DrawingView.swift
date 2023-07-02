//
//  DrawingView.swift
//  PencilKitDemo290623
//
//  Created by Afina R. Vinci on 02/07/23.
//

import SwiftUI
import PencilKit

struct DrawingView: View {
    @State private var selectedHandwritingType = 0
    var imageNames = ["cursive", "printscript", "grid"]
    @State private var canvasView = PKCanvasView()
    @State private var isSharing = false
    @State private var isSetting = false
    @State private var isHidingBg = false
    
    var body: some View {
        ZStack {
            Color.paperCream
            
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .shadow(color: .greyShadow, radius: 20, x: 10, y: 10)
                .padding(50)
            
            VStack(alignment: .leading) {
                
                if selectedHandwritingType == 2 {
                
                    Image(imageNames[selectedHandwritingType])
                        .resizable()
                        .scaledToFit()
                        .opacity(isHidingBg ? 0 : 0.05)
                        .rotationEffect(.degrees(90))
                        .frame(maxWidth: .infinity)
                        .padding([.trailing, .leading], -300)
                        .padding([.top, .bottom], 150)
                        
                } else {
                    
                    ForEach(0..<3) {_ in
                        Image(imageNames[selectedHandwritingType])
                            .resizable()
                            .scaledToFit()
                            .opacity(isHidingBg ? 0 : 0.1)
                            .padding([.top, .bottom], -100)
                    }
                    Spacer()
                }
            }
            .clipped()
            .padding([.top, .bottom], 100)
            
            GeometryReader { geo in
                PKCanvasViewRepresentable(canvasView: $canvasView)
                    .frame(width: geo.size.width - 100, height: geo.size.height - 100)
                    .cornerRadius(20)
                    .padding(50)
                
                VStack(alignment: .trailing) {
                    
                    HStack {
                        
                        Button {
                            isHidingBg.toggle()
                        } label : {
                            Image(systemName: isHidingBg ? "eye" : "eye.slash")
                        }
                        .modifier(TopButtonModifier())
                        
                        Spacer()
                        
                        Button(action: shareDrawing) {
                            Image(systemName: "square.and.arrow.up")
                        }.sheet(isPresented: $isSharing) {
                            let image = canvasView.drawing.image(from: canvasView.bounds, scale: UIScreen.main.scale)
                            ShareSheetViewRepresentable(
                                activityItems: [image],
                                excludedActivityTypes: [])
                        }
                        .modifier(TopButtonModifier())
                        
                        Button(action: setting) {
                            Image(systemName: "gear")
                        }
                        .modifier(TopButtonModifier())
                        .popover(isPresented: $isSetting, arrowEdge: .top) {
                            VStack {
                                Text("Handwriting Guide")
                                Picker("", selection: $selectedHandwritingType) {
                                    Text("Cursive").tag(0)
                                    Text("Printscript").tag(1)
                                    Text("Grid").tag(2)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }
                            .padding()
                        }
                    }
                    .padding(50)
                }
            }
                
        }
        
    }
    
    func shareDrawing() {
        isSharing = true
    }
    
    func setting() {
        isSetting = true
    }
}

struct DrawingView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView()
    }
}
