//
//  SwiftUIView.swift
//  Pok’Uk
//
//  Created by Alonso Huerta on 19/02/25.
//

import SwiftUI

extension Game {
    var Achievements: some View {
        ZStack {
            Color.white
            Color("Supplement").opacity(0.8)
            ScrollView {
                Text("Achievements")
                    .font(.custom("Mayan", size: 60))
                    .foregroundStyle(.white)
                    .padding(.top, 10)
                    .padding(.vertical, 50)
                    .frame(maxWidth: .infinity)
                    .background(Color("Supplement").opacity(0.4))
                    .padding(.bottom, 10)
            }
        }
    }
}
