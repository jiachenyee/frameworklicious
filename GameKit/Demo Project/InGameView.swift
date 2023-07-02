//
//  InGameView.swift
//  Demo Project
//
//  Created by Gerson Janhuel on 24/06/23.
//

import SwiftUI

struct InGameView: View {
    @ObservedObject var matchManager: MatchManager
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var tapScore: Int = 0
    @State private var timeRemaining = 0
    
    var body: some View {
        GeometryReader { geometry in
            let perSecondWidth = (geometry.size.width - 16) / CGFloat(matchManager.gameDuration)
            
            let countDownBarWith = perSecondWidth * CGFloat(timeRemaining)
            
            ZStack {
                VStack {
                    
                    HStack {
                        matchManager.myAvatar
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        
                        
                        Text("VS")
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        matchManager.opponentAvatar
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    .padding(.top, 50)
                    
                    HStack(alignment: .center) {
                        
                        Text("\(matchManager.localPlayer.displayName)")
                            .frame(width: 150, alignment: .trailing)
                            .font(.title3)
                        
                        
                        Spacer()
                            .frame(width: 50)
                        
                        
                        Text("\(matchManager.otherPlayer?.displayName ?? "-")")
                            .frame(width: 150, alignment: .leading)
                            .font(.title3)
                    }
                    
                    .padding(.bottom, 30)
                    
                    
                    // Tappable Area
                    VStack {
                        
                        if timeRemaining <= 0 {
                            Text("Time is up!".uppercased())
                                .font(.system(size: 20).bold())
                                .foregroundColor(.red)
                                .frame(height: 40)
                            
                        } else {
                            HStack {
                                
                                Rectangle()
                                    .foregroundColor(.green)
                                    .frame(width: countDownBarWith, height: 30)
                                    .cornerRadius(4)
                                    .animation(.default, value: timeRemaining)
                                
                                Spacer()
                            }
                            .frame(width: geometry.size.width)
                            .padding(.top, 8)
                            .padding(.horizontal, 8)
                            
                        }
                        
                        
                        
                        HStack {
                            Text("Tap Me!")
                                .font(.system(size: 70).bold().italic())
                                .foregroundColor(.gray)
                            
                        }
                        .frame(maxHeight: .infinity)
                        
                            
                        Spacer()
                        
                        HStack {
                            
                            Text("\(tapScore)")
                                .padding()
                                .font(.system(size: 100).bold().italic())
                                .frame(height: 100)
                                .foregroundColor(Color("dark-yellow"))
                        }
                        
                            
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color("custom-purple"))
                    .onTapGesture {
                        
                        if timeRemaining > 0 {
                            tapScore += 1
                        }
                        
                    }
                    
                }
            }
        }
        
        .onAppear {
            // TODO: Add countdown timer
            timeRemaining = matchManager.gameDuration
            
        }
        .onReceive(timer) { time in
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer.upstream.connect().cancel()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    // end game
                    matchManager.endGame(withScore: tapScore)
                }
                
            }
            
        }
    }
}

struct InGameView_Previews: PreviewProvider {
    static var previews: some View {
        InGameView(matchManager: MatchManager())
    }
}
