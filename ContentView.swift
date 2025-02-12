import SwiftUI

// FIXME Navigation Stack breaks background

struct ContentView: View {
    
    init() {
        MayanFont.registerFonts()
    }

    let backgroundImageName = "Background"
    let animationDuration: Double = 30 // Adjust for speed
    @State private var offset: CGFloat = 0
    
    var body: some View {
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
                    VStack {
                        Text("Pok'Uk")
                            .font(.custom("Mayan", size: 120))
                            .padding(.top, 30)
                            .background(Color.orange.opacity(0.4))
                            .padding(.vertical, 60)

                        NavigationLink(destination: {
                            Game()
                                .navigationBarBackButtonHidden()
                        }, label: {
                            Text("Play")
                                .font(.custom("Mayan", size: 80))
                        })
                    }
                }
                .ignoresSafeArea()
            }
            .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
}
