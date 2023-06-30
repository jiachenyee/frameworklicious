//
//  ContentView.swift
//  CoreML Sample
//
//  Created by Rizal Hilman on 27/06/23.
//

import SwiftUI

struct CameraViewUIKit: View {
    
    @State var resultLabel: String
    var body: some View {
        VStack {
            ZStack {
                Text(resultLabel)
                SwiftUIAVCaptureVideoPreviewView(result: $resultLabel)
                    .ignoresSafeArea(.all, edges: .all)
            }
        }
    }
}

struct CameraViewUIKit_Previews: PreviewProvider {
    static var previews: some View {
        CameraViewUIKit(resultLabel: "item found")
    }
}
