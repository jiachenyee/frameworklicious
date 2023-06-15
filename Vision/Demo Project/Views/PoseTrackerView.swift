//
//  PoseTrackerView.swift
//  Demo Project
//
//  Created by Jia Chen Yee on 12/06/23.
//

import Foundation
import SwiftUI
import Vision

struct PoseTrackerView: View {
    @StateObject var poseTracker = PoseTrackerManager()

    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            // Display Vision camera view
            CameraView(detectedPoints: $poseTracker.detectedPoints) { photo in
                poseTracker.setRandomPhoto(photo)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .opacity(0.1)
            
            GeometryReader { geometry in
                if poseTracker.userState == .started {
                    // Create hand hover highlight rectangles
                    ForEach(poseTracker.selectedSections, id: \.0) { content in
                        PositionedRectangle(targetPosition: content.position,
                                            color: content.hand.color.opacity(0.3),
                                            geometry: geometry)
                    }
                    
                    // Create target rectangle
                    PositionedRectangle(targetPosition: poseTracker.targetPosition,
                                        color: poseTracker.targetHand.color,
                                        geometry: geometry)
                }
                
                PosePreviewView(detectedPoints: poseTracker.detectedPoints)
                    .onAppear {
                        poseTracker.viewSize = geometry.size
                    }
            }
            
            switch poseTracker.userState {
            case .waitingToStart:
                VStack {
                    Image(systemName: "hands.clap.fill")
                        .imageScale(.large)
                    Text("Clap to start")
                        .font(.headline)
                    Text("You have 20s")
                    Text("Hit the blue and red squares using your wrists!")
                        .multilineTextAlignment(.center)
                }
                .frame(width: 200, height: 200)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(8)
                
            case .started:
                ZStack {
                    Gauge(value: Double(poseTracker.gameSeconds), in: 0...20.0) {
                        EmptyView()
                    } currentValueLabel: {
                        EmptyView()
                    }
                    .gaugeStyle(.accessoryCircularCapacity)

                    Text("\(poseTracker.gameScore)")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.top, 64)
            case .gameOver:
                ZStack {
                    Color.black
                    VStack {
                        Text("Game Over")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("\(poseTracker.gameScore)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        if let latestImage = poseTracker.randomPhoto {
                            ZStack(alignment: .bottomLeading) {
                                Image(uiImage: latestImage)
                                    .resizable()
                                    .scaledToFit()
                                Text("FRAMEWORKLICIOUS @ ILB")
                                    .font(.system(size: 18, design: .monospaced))
                                    .foregroundColor(.white)
                                    .background(.black)
                                    .padding()
                            }
                        }
                        
                        Button("Play Again") {
                            poseTracker.userState = .waitingToStart
                        }
                    }
                    .padding()
                    .padding()
                }
            }
        }
    }
}
