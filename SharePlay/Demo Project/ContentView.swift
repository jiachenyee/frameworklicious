//
//  ContentView.swift
//  TarikUlur
//
//  Created by Muhammad Tafani Rabbani on 12/06/23.
//

import SwiftUI


struct SharePlayView: View {
    var gameHoleSize: Double = 120
    @StateObject var viewModel = GameViewModel(model: GameModel())
    @State var counter = 0
    var body: some View {
        ZStack {
            
            VStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(.red)
                        .opacity((viewModel.isDissable == -1) ? 0.6 : 1)
                    .ignoresSafeArea()
                    HStack {
                        Text("Swipe")
                            .bold()
                            .font(.system(size: 40))
                        Image(systemName: "hand.point.left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                    }.foregroundColor(.white)
                }.gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onEnded({ value in
                            print(viewModel.isDissable)
                            if viewModel.isDissable != -1{
                                if value.translation.width < 0 {
                                    // left
                                    withAnimation {
                                        viewModel.decreaseBallPosition()
                                    }

                                }

                                if value.translation.width > 0 {
                                    // right
                                    withAnimation {
                                        viewModel.increaseBallPosition()
                                    }
                                    counter+=1
                                    if counter > 3{
                                        withAnimation {
                                            viewModel.pushTheRope(index: 1)
                                        }
                                        
                                        counter = 0
                                    }
                                    print(counter)
                                }
                            }

                        })
                )
                HStack {
                    Circle()
                        .foregroundColor(.red)
                        .frame(width: 50)
                        .overlay((viewModel.isDissable == -1) ? Text("🥵").bold().foregroundColor(.white).font(.system(size: 20)) : Text("😤").bold().foregroundColor(.white).font(.system(size: 30)) )
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 120, height: 10)
                        .foregroundColor(.brown)
                    Circle()
                        .foregroundColor(.blue)
                        .frame(width: 50)
                        .overlay((viewModel.isDissable == 1) ? Text("🥵").bold().foregroundColor(.white).font(.system(size: 20)) : Text("😤").bold().foregroundColor(.white).font(.system(size: 30)) )
        //                .disabled()
                        

                }
                  .offset(x:viewModel.gameXOffset)
                ZStack {
                    Rectangle()
                        .foregroundColor(.blue)
                        .opacity((viewModel.isDissable == 1) ? 0.6 : 1)
                    .ignoresSafeArea()
                    HStack {
                        Text("Swipe")
                            .bold()
                            .font(.system(size: 40))
                        Image(systemName: "hand.point.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                    }.foregroundColor(.white)
                }
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onEnded({ value in
                            print(viewModel.isDissable)
                            if viewModel.isDissable != 1{
                                if value.translation.width < 0 {
                                    // left
                                    withAnimation {
                                        viewModel.decreaseBallPosition()
                                    }
                                    counter-=1
                                    if counter < -3{
                                        withAnimation {
                                            viewModel.pushTheRope(index: -1)
                                        }
                                        
                                        counter = 0
                                    }
                                    print(counter)

                                }

                                if value.translation.width > 0 {
                                    // right
                                    withAnimation {
                                        viewModel.increaseBallPosition()
                                    }

                                }
                            }

                        })
                )
            }
            .disabled(viewModel.gameState != .playing)
            .opacity(viewModel.gameState != .playing ? 0.3 : 1)
            
            VStack {
                
                HStack {
                    Button(action: {
                        viewModel.startSharing()
                    }) {
                        Image(systemName: "shareplay")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(10)
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .background(.gray)
                            .cornerRadius(10)
                    }
                    .buttonStyle(.plain)
                    Spacer()
                    Button(action: {
                        withAnimation {
                            viewModel.resetGame()
                        }
                    }) {
                        Image(systemName: "arrow.counterclockwise")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(15)
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .background(.gray)
                            .cornerRadius(10)
                    }
                    .buttonStyle(.plain)
                    
                }
//                Spacer()
            }.padding()
            if viewModel.gameState != .playing{
                Text(viewModel.gameState?.title ?? "")
                    .font(.system(size: 100))
                    .bold()
            }
            
            
        }
        .task {
            for await session in SharePlayActivity.sessions() {
                viewModel.configureGroupSession(session)
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
