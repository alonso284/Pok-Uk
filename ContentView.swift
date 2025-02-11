import SwiftUI

// FIXME Navigation Stack breaks background

struct ContentView: View {
    
    init() {
        MayanFont.registerFonts()
    }
    @State var playing = false

    var body: some View {
        if !playing {
            ZStack {
                Background()
                    .ignoresSafeArea()

                // Logo & Button
                VStack {
//                    Image("Logo")
//                        .padding(.bottom, 200)
                    Text("Pok'Uk")
                        .font(.custom("Mayan", size: 120))
                        .padding(.top, 30)
                        .padding(40)
                        .frame(maxWidth: .infinity) // Makes width as big as possible
                        .background(Color.orange.opacity(0.4))
                        .padding(.vertical, 60)
                    
                    Button(action: {
                        playing = true
                    }, label: {
//                        Image("Play")
                        Text("Play")
                            .font(.custom("Mayan", size: 80))
                    })
                }
            }
        } else {
            Game(playing: $playing)
        }
//        NavigationStack {
//            ZStack {
//
//                Background()
//                    .ignoresSafeArea()
//
//                // Logo & Button
//                VStack {
//                    Image("Logo")
//                        .padding(.bottom, 200)
//                    
//                    NavigationLink(destination: {
//                        Game()
//                            .navigationBarBackButtonHidden()
//                    }, label: {
//                        Image("Play")
//                    })
//                }
//            }
//            .toolbar(content: {
//                ToolbarItem(placement: .topBarTrailing, content: {
//                    Button(action: {
//                        
//                    }, label: {
//                        CircleButton(systemName: "questionmark", color: .black)
//                    })
//                })
//            })
//        }

    }
}
