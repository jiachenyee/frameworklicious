import SwiftUI

struct AirHockeyView: View {
    @StateObject private var viewModel: AirHockeyViewModel
    
    init(multipeerHandler: MultipeerHandler, parentViewModel: StartViewModel) {
        _viewModel = StateObject(wrappedValue: AirHockeyViewModel(multipeerHandler: multipeerHandler, parentViewModel: parentViewModel))
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.green.edgesIgnoringSafeArea(.all)
                
                Circle()
                    .stroke(.black, lineWidth: 4)
                    .frame(width: geometry.size.width/2, height: geometry.size.width/2)
                    .foregroundColor(.white)
                
                Rectangle()
                    .frame(width: geometry.size.width, height: 4)
                    .foregroundColor(.black)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                
                BallView(size: viewModel.puckSize)
                    .position(viewModel.puckPosition)
                
                PlayerView(positionX: viewModel.player1Position.x, positionY: viewModel.player1Position.y, size: viewModel.paddleSize, color: .yellow)
                
                PlayerView(positionX: viewModel.player2Position.x, positionY: viewModel.player2Position.y, size: viewModel.paddleSize, color: .red)
                
                VStack {
                    // Scoreboard
                    HStack {
                        HStack(spacing: 40) {
                            Button("Reset") {
                                viewModel.resetScore()
                            }
                            Button("Exit") {
                                viewModel.endGame()
                            }
                        }.rotationEffect(Angle(degrees: 90))
                        Spacer() //if I add spacer here, the score and button disappear
                        VStack{
                            Text("Player 1 Score       Player 2 Score")
                                .font(.title2)
                            Text("\(viewModel.player1Score)       \(viewModel.player2Score)")
                                .font(.title)
                        }.rotationEffect(Angle(degrees: 90))
                        
                    }
                }
            }
            .onAppear {
                viewModel.geometriSize = geometry.size
                viewModel.player1Position = CGPoint(x: geometry.size.width / 2, y: viewModel.paddleSize.height / 2)
                viewModel.player2Position = CGPoint(x: geometry.size.width / 2, y: geometry.size.height - viewModel.paddleSize.height / 2)
                viewModel.startPuckMovementTimer()
            }
            .alert("Device \(viewModel.disconnectedPlayer?.displayName ?? "") is disconnected", isPresented: Binding<Bool>(get: {
                viewModel.showAlert
            }, set: { _, _ in
                viewModel.showAlert.toggle()
            }) ) {
                Button("OK", role: .cancel) {
                    viewModel.endGame()
                }
            }
            .alert("Congrats \(viewModel.winner ?? "") win!", isPresented: Binding<Bool>(get: {
                viewModel.showAlertWin
            }, set: { _, _ in
                viewModel.showAlert.toggle()
            }) ) {
                Button("Play Again", role: .cancel) {
                    viewModel.resetScore()
                }
//                Button("Exit", role: .cancel) {
//                    viewModel.endGame()
//                }
            }
        }.onAppear {
            UIApplication.shared.isIdleTimerDisabled = true
        }.onDisappear {
            UIApplication.shared.isIdleTimerDisabled = false
        }
    }
}

struct BallView: View {
    let size: CGSize
    
    var body: some View {
        Circle()
            .frame(width: size.width, height: size.height)
            .foregroundColor(.black)
    }
}

struct PlayerView: View {
    var positionX: CGFloat
    var positionY: CGFloat
    let size: CGSize
    var color: Color
    
    var body: some View {
        Rectangle()
            .frame(width: size.width, height: size.height)
            .position(x: positionX, y: positionY)
            .foregroundColor(color)
    }
}

//struct AirHockeyView_Previews: PreviewProvider {
//    static var previews: some View {
//        AirHockeyView()
//    }
//}
