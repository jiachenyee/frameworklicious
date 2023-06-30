//
//  AnimationPlaygroundScreen.swift
//  SwiftAnimation
//
//  Created by Bisma Mahendra I Dewa Gede on 22/06/23.
//

import SwiftUI

enum FillColor: String, CaseIterable {
    case red, orange, yellow, green, mint, teal, cyan, blue, indigo, purple, pink, brown, white, gray, black, clear
}

struct AnimationPlaygroundScreen: View {
    @EnvironmentObject var colorTheme: ColorTheme
    
    @State var animated = false
    @State var timeAlgo: TimeAlgo = .linear
    @State var configuration = GeneralConfiguration(duration: "1", response: "1", dampingFraction: "1", speed: "1", delay: "0", repeatCount: "1", repeatMode: .none)
    @State var rectangle = RectangleState()
    @State var positionX = AnimatedState(before: "196", after: "196")
    @State var positionY = AnimatedState(before: "106", after: "106")
    @State var scale = AnimatedState(before: "1", after: "1")
    @State var offsetX = AnimatedState(before: "0", after: "0")
    @State var offsetY = AnimatedState(before: "0", after: "0")
    @State var rotation = AnimatedState(before: "0", after: "0")
    @State var blur = AnimatedState<CGFloat>(before: 0, after: 0)
    @State var opacity = AnimatedState<CGFloat>(before: 1, after: 1)
    @State var fillColor = AnimatedState<FillColor>(before: .black, after: .black)
    
    func resetAnimation() {
        timeAlgo = .linear
        configuration = GeneralConfiguration(duration: "1", response: "1", dampingFraction: "1", speed: "1", delay: "0", repeatCount: "1", repeatMode: .none)
         rectangle = RectangleState()
         positionX = AnimatedState(before: "196", after: "196")
         positionY = AnimatedState(before: "106", after: "106")
         scale = AnimatedState(before: "1", after: "1")
         offsetX = AnimatedState(before: "0", after: "0")
         offsetY = AnimatedState(before: "0", after: "0")
         rotation = AnimatedState(before: "0", after: "0")
         blur = AnimatedState<CGFloat>(before: 0, after: 0)
         opacity = AnimatedState<CGFloat>(before: 1, after: 1)
         fillColor = AnimatedState<FillColor>(before: .black, after: .black)
         animated = false
    }
   
    var body: some View {
        GeometryReader { geo in
            let frameWidth = geo.size.width
            let frameHeight = UIScreen.main.bounds.height * (1/4)
           
            VStack(spacing: 12) {
                VStack() {
                    HStack {
                        Text("Frame width: **\(frameWidth.formatted())**")
                        Text("Frame height: **\(frameHeight.formatted())**")
                    }
                    
                    HStack {
                        Text("Rectangle width: **\(rectangle.widthVal.formatted())**")
                        Text("Rectangle height: **\(rectangle.heightVal.formatted())**")
                    }
                }
                
                AnimationDisplayView {
                    Rectangle()
                        .fill(animated ? fillColor.afterVal : fillColor.beforeVal)
                        .frame(
                            width: rectangle.widthVal,
                            height: rectangle.heightVal
                        )
                        .scaleEffect(animated ? scale.afterVal : scale.beforeVal)
                        .rotationEffect(
                            .degrees(animated ? rotation.afterVal : rotation.beforeVal)
                        )
                        .position(
                            CGPoint(
                                x: animated ? positionX.afterVal : positionX.beforeVal,
                                y: animated ? positionY.afterVal : positionY.beforeVal
                            )
                        )
                        .offset(
                            x: animated ? offsetX.afterVal : offsetX.beforeVal,
                            y: animated ? offsetY.afterVal : offsetX.beforeVal
                        )
                        .blur(
                            radius: animated ? blur.afterVal : blur.beforeVal
                        )
                        .opacity(animated ? opacity.afterVal : opacity.beforeVal)
                        .animation(.getAnimation(timeAlgo: timeAlgo, configuration: configuration), value: animated)
                }
                .frame(width: frameWidth, height: frameHeight)
                .background(.blue)
                .clipped()
                
                HStack {
                    Button {
                        animated.toggle()
                    } label: {
                        Text(animated ? "Revert" : "Animate")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button {
                        resetAnimation()
                    } label: {
                        Text("Reset")
                    }
                    .buttonStyle(.borderedProminent)
                }
                
                ScrollView {
                    Section {
                        HStack {
                            C4Picker(
                                value: $timeAlgo,
                                segmented: true,
                                label: "Time Curve Algorithm"
                            ) {
                                Group {
                                    ForEach(TimeAlgo.allCases, id: \.self) { item in
                                        Text("\(item.rawValue)").tag(item)
                                    }
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            if timeAlgo == .spring {
                                C4NumberField(number: $configuration.response, placeholder: "1", label: "Response")
                                
                                C4NumberField(number: $configuration.dampingFraction, placeholder: "1", label: "Damping Fraction")
                            } else {
                                C4NumberField(number: $configuration.duration, placeholder: "1", label: "Duration")
                            }
                        }
                        .padding(.horizontal)
                        
                        HStack(alignment: .bottom) {
                            C4NumberField(number: $configuration.speed, placeholder: "1", label: "Speed")
                            
                            C4NumberField(number: $configuration.delay, placeholder: "0", label: "Delay")
                            
                            C4Picker(value: $configuration.repeatMode, label: "Repeat") {
                                Group {
                                    Text("None").tag(Repeat.none)
                                    Text("Count").tag(Repeat.count)
                                    Text("Forever").tag(Repeat.forever)
                                }
                            }
                            
                            if configuration.repeatMode == .count {
                                C4NumberField(number: $configuration.repeatCount, placeholder: "1", label: "")
                                    .frame(maxWidth: 40)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Section {
                        HStack {
                            Text("Before")
                            
                            Spacer()
                            
                            Image(systemName: "arrow.right")
                            
                            Spacer()
                            
                            Text("After")
                        }
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        
                        
                        VStack {
                            HStack {
                                C4Picker(value: $fillColor.before, label: "Fill Color") {
                                    Group {
                                        ForEach(FillColor.allCases, id: \.self) { item in
                                            Text(item.rawValue).tag(item)
                                        }
                                    }
                                }
                                
                                C4Picker(value: $fillColor.after, label: "Fill Color") {
                                    Group {
                                        ForEach(FillColor.allCases, id: \.self) { item in
                                            Text(item.rawValue).tag(item)
                                        }
                                    }
                                }
                            }
                            
                            HStack {
                                C4NumberField(number: $scale.before, placeholder: "1", label: "Scale")
                                
                                C4NumberField(number: $scale.after, placeholder: "1.2", label: "Scale")
                            }
                            
                            HStack {
                                C4NumberField(number: $rotation.before, placeholder: "360", label: "Rotation")
                                
                                C4NumberField(number: $rotation.after, placeholder: "180", label: "Rotation")
                            }
                            
                            HStack {
                                C4NumberField(number: $positionX.before, placeholder: "120", label: "Position X")
                                
                                C4NumberField(number: $positionX.after, placeholder: "120", label: "Position X")
                            }
                            
                            HStack {
                                C4NumberField(number: $positionY.before, placeholder: "120", label: "Position Y")
                                
                                C4NumberField(number: $positionY.after, placeholder: "120", label: "Position Y")
                            }
                            
                            HStack {
                                C4NumberField(number: $offsetX.before, placeholder: "120", label: "Offset X")
                                
                                C4NumberField(number: $offsetX.after, placeholder: "120", label: "Offset X")
                            }
                            
                            HStack {
                                C4NumberField(number: $offsetY.before, placeholder: "120", label: "Offset Y")
                                
                                C4NumberField(number: $offsetY.after, placeholder: "120", label: "Offset Y")
                            }
                            
                            HStack {
                                C4Slider(value: $opacity.before, label: "Opacity")
                                
                                C4Slider(value: $opacity.after, label: "Opacity")
                            }
                            
                            HStack {
                                C4Slider(value: $blur.before, label: "Blur", range: 0...30)
                                
                                C4Slider(value: $blur.after, label: "Blur", range: 0...30)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button {
                        hideKeyboard()
                    } label: {
                        Text("Done")
                    }
                }
            }
        }
        .onAppear {
            colorTheme.setToLight()
        }
    }
}

struct AnimationPlaygroundScreen_Previews: PreviewProvider {
    static var previews: some View {
        AnimationPlaygroundScreen()
    }
}
