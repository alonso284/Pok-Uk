import SwiftUI

// FIXME Navigation Stack breaks background

struct ContentView: View {
    
    init() {
        MayanFont.registerFonts()
    }

    // variables for moving background
    let backgroundImageName = "Background"
    let animationDuration: Double = 30
    @State private var offset: CGFloat = 0
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                let containerHeight = geometry.size.height
                let imageSize = UIImage(named: backgroundImageName)?.size ?? .zero
                let imageAspectRatio = imageSize.width / imageSize.height
                let scaledWidth = containerHeight * imageAspectRatio
                NavigationStack {
                    ZStack {
                        HStack(spacing: 0){
                            Image(backgroundImageName)
                                .resizable()
                                .scaledToFill()
                                .clipped()
                            Image(backgroundImageName)
                                .resizable()
                                .scaledToFill()
                                .clipped()
                            Image(backgroundImageName)
                                .resizable()
                                .scaledToFill()
                                .clipped()
                        }
                        // Functions for shifting background
                        .offset(x: offset)
                        .onAppear {
                            offset = 0
                            withAnimation(
                                Animation.linear(duration: animationDuration)
                                    .repeatForever(autoreverses: false)
                            ) {
                                offset = -scaledWidth
                            }
                        }
                        Color(white: 0, opacity: 0.2)
                        
                        // Logo & Button
                        // FIXME: They are not centered
                        
                        VStack(spacing: 0) {
                            Text("Pok'Uk")
                                .font(.custom("Mayan", size: 120))
                                .padding(.top, 30)
                                .padding(.vertical, 80)
                                .frame(maxWidth: .infinity)
                                .background(Color.orange.opacity(0.4))
                            
                            NavigationLink(destination: Game().navigationBarBackButtonHidden(true)) {
                                Text("Play")
                                    .font(.custom("Mayan", size: 80))
                                    .foregroundStyle(.primary)
                                    .padding(.vertical, 40)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.purple.opacity(0.2))
                            }
                            
                        }
                        // FIXME: NOW
                        .offset(x: -230)
                        .frame(maxWidth: .infinity)
                        
                    }
                    .ignoresSafeArea()
                }
            }
        }
        .onAppear {
            offset = 0
        }
    }
}
