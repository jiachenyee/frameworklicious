//
//  CameraView.swift
//  CoreML Sample
//
//  Created by Rizal Hilman on 27/06/23.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    
    @StateObject private var model = DataModel()
    private static let barHeightFactor = 0.15
    
    @State var audioPlayer: AVAudioPlayer!
    
    // MARK: prediction views
    private var targetLabel = "banana fruit"
    @State var isBananaFound: Bool = false
    
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    ViewfinderView(image: $model.viewfinderImage)
                        .onChange(of: model.camera.result.identifier) { newValue in
                            print("Found: \(newValue)")
                            
                            if newValue == targetLabel {
                                isBananaFound = true
                                playHaptic()
                                audioPlayer.play()
                            } else {
                                isBananaFound = false
                            }
                        }
                    
                    Rectangle()
                        .background(.black)
                        .opacity(isBananaFound ? 0.3 : 0)
                    
                    Image("banana")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(0.7)
                        .opacity(isBananaFound ? 1 : 0 )
                        .overlay {
                            VStack {
                                Text("GOTCHA!")
                                    .font(Font.system(size: 40))
                                    .fontWeight(.bold)
                                    .offset(y: 180)
                                    .foregroundColor(.yellow)
                                    .opacity(isBananaFound ? 1 : 0 )
                                Text("it's \(model.camera.result.confidence)% \(model.camera.result.identifier)!")
                                    .font(Font.system(size: 20))
                                    .fontWeight(.bold)
                                    .offset(y: 180)
                                    .foregroundColor(.yellow)
                                    .opacity(isBananaFound ? 1 : 0 )
                            }
                        }
                    
                    
                }
                
            }
            .task {
                await model.camera.start()
            }
            .navigationTitle("Camera")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .ignoresSafeArea()
            .statusBar(hidden: true)
            .onAppear {
                let sound = Bundle.main.path(forResource: "bell_sound", ofType: "mp3")
                self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            }
        }
    }
    
    private func playHaptic() {
        let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
        impactHeavy.impactOccurred()
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
