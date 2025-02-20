import SwiftUI

// FIXME Navigation Stack breaks background

struct ContentView: View {
    
    init() {
        MayanFont.registerFonts()
    }

    // variables for moving background
    let backgroundImageName = "Background"
    let animationDuration: Double = 120
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
                            offset = -scaledWidth
                            withAnimation(
                                Animation.linear(duration: animationDuration)
                                    .repeatForever(autoreverses: false)
                            ) {
                                offset = 2 * -scaledWidth
                            }
                        }
                        Color(white: 0, opacity: 0.2)
                        
                        // Logo & Button
                        // FIXME: They are not centered
                        
                        VStack(spacing: 0) {
//                            Text("Pok'Uk")
//                                .font(.custom("Mayan", size: 120))
//                                .padding(.top, 30)
//                                .padding(.vertical, 80)
//                                .frame(maxWidth: .infinity)
//                                .background(Color("Base").opacity(0.4))
//                            TextBox(text: "Pok'Uk", color: Color("Base"), multplier: 1.2)
                            CustomTextBox(text: "Pok'Uk")
                            
                            
                            NavigationLink(destination: Game().navigationBarBackButtonHidden(true)) {
//                                Text("Play")
//                                    .font(.custom("Mayan", size: 80))
//                                    .foregroundStyle(Color("Base"))
//                                    .padding(.top, 80)
//                                    .frame(maxWidth: .infinity)
////                                    .background(Color("Trees").opacity(0.2))
                                
                                ZStack {
                                    
//                                    Image("Base")
//                                        .resizable()
//                                        .frame(width: 240, height: 120)
//                                        .clipped()
                                    
                                    Color(.white)
                                    
                                    
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
                            
                        }
                        // FIXME: NOW
                        .offset(x: -230)
                        .frame(maxWidth: .infinity)
                        
                    }
                    .ignoresSafeArea()
                }
            }
        }
    }
}
