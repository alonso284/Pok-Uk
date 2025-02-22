import SwiftUI

// FIXME Navigation Stack breaks background

struct ContentView: View {
    
    init() {
        MayanFont.registerFonts()
    }

    // Variables for moving background
    let backgroundImageName = "Background"
    let animationDuration: Double = 120
    @State private var offset: CGFloat = 0
    
    // Show buttons
    @State private var showButton:  Bool = false
    @State private var showLogo:    Bool = false
    
    
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
                            CustomTextBox(text: "Pok'Uk")
                                .opacity((showLogo ? 1 : 0))
                            
                            // Play Button
                            NavigationLink(destination: Game().navigationBarBackButtonHidden(true)) {
                                ZStack {
                                    Color.white
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color("Trees"), lineWidth: 15)
                                        .fill(Color("TreesLight").opacity(0.8))
                                    
                                    Image(systemName: "play.circle.fill")
                                        .foregroundStyle(Color("TreesLight"))
                                        .font(.system(size: 80, weight: .bold))
                                }
                                .frame(width: 200, height: 120)
                                    
                            }
                            .padding(.top, 80)
                            .opacity((showButton ? 1 : 0))
                            
                        }
                        
                        // FIXME: NOW
                        .offset(x: -230)
                        .onAppear {
                            // Animate the logo with a 3-second duration
                            withAnimation(.easeInOut(duration: 3)) {
                                showLogo = true  // Set showLogo to true with animation
                            }
                            
                            // Delay the button appearance by 3 seconds, so it starts after the logo animation
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation(.easeInOut(duration: 2)) {
                                    showButton = true  // Set showButton to true with animation
                                }
                            }
                        }
                    }
                    .ignoresSafeArea()
                }
            }
        }
    }
}
