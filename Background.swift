//
//  Background.swift
//  Pok’Uk
//
//  Created by Alonso Huerta on 05/02/25.
//

import SwiftUI

// FIXME Background not working well in main view do to Navigation Stack

struct Background: View {
    
    let backgroundImageName = "Background"
    let animationDuration: Double = 60 // Adjust for speed
    @State private var offset: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            let containerWidth = geometry.size.width
            let containerHeight = geometry.size.height
            
            let imageSize = UIImage(named: backgroundImageName)?.size ?? .zero
            let imageAspectRatio = imageSize.width / imageSize.height
            
            let scaledWidth = containerHeight * imageAspectRatio
            let scaledHeight = containerHeight
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
                }
                .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    Background()
}
