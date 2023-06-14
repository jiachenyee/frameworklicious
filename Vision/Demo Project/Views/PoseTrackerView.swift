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
            CameraView(detectedPoints: $poseTracker.detectedPoints)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geometry in
                ForEach(poseTracker.selectedSections, id: \.0) { content in
                    Rectangle()
                        .fill(content.hand.color.opacity(0.3))
                        .frame(width: geometry.size.width / 3,
                               height: geometry.size.height / 5)
                        .offset(x: CGFloat(content.position.x) * geometry.size.width / 3,
                                y: CGFloat(content.position.y) * geometry.size.height / 5)
                }
                Rectangle()
                    .fill(poseTracker.targetHand.color)
                    .frame(width: geometry.size.width / 3,
                           height: geometry.size.height / 5)
                    .offset(x: CGFloat(poseTracker.targetPosition.x) * geometry.size.width / 3,
                            y: CGFloat(poseTracker.targetPosition.y) * geometry.size.height / 5)
                    .onAppear {
                        poseTracker.viewSize = geometry.size
                    }
            }
            
            ForEach(poseTracker.detectedPoints.map({
                (key: $0, value: $1)
            }), id: \.key) { point in
                ZStack {
                    
                    Circle()
                        .fill(Hand(point.key)?.color ?? .white)
                }
                .frame(width: 20, height: 20)
                .position(point.value)
            }
        }
    }
}
