import SwiftUI

@available(iOS 16.0, *)
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct FrameworkliciousApp<Content: View>: View {
    
    public var framework: Framework
    
    @ViewBuilder public var content: Content
    
    @StateObject var viewModel = FrameworkliciousViewModel()
    
    public init(framework: Framework, content: (() -> Content)) {
        self.framework = framework
        self.content = content()
        
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    public var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            ZStack {
                Color.black.ignoresSafeArea()
                VStack(alignment: .leading) {
                    ZStack {
                        Image(systemName: framework.icon)
                            .foregroundColor(.white.opacity(0.25))
                            .font(.system(size: 128))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        VStack(alignment: .leading) {
                            Text("Frameworklicious")
                                .textCase(.uppercase)
                                .font(.caption)
                            Text(framework.name)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Text(framework.subtitle)
                                .font(.title2)
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                    .padding(.vertical)
                    .background(
                        LinearGradient(colors: [
                            .black, framework.color.opacity(0.5)
                        ], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .background(.black)
                    .cornerRadius(8)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(framework.color, lineWidth: 5)
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.black.opacity(0.5), lineWidth: 5)
                    }
                    
                    ScrollView {
                        Text(framework.description)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.white)
                            .padding(.top)
                    }
                    
                    Button {
                        viewModel.isFrameworkPresented = true
                    } label: {
                        Text("Try it out!")
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(framework.color)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            .fullScreenCover(isPresented: $viewModel.isFrameworkPresented) {
                ZStack(alignment: .topLeading) {
                    content
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    Button {
                        viewModel.isFrameworkPresented = false
                    } label: {
                        ZStack {
                            Circle()
                                .fill(.white)
                                .frame(width: 32, height: 32)
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .padding()
                        }
                    }
                    .tint(.gray)
                }
            }
        }
        .simultaneousGesture(
            TapGesture()
                .onEnded { _ in
                    viewModel.lastInteractionDate = .now
                }
        )
        .preferredColorScheme(.dark)
    }
}

enum FrameworkState {
    case welcome
    case framework
}
