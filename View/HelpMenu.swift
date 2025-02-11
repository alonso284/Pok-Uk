//
//  HelpCard.swift
//  Pok’Uk
//
//  Created by Alonso Huerta on 10/02/25.
//

import SwiftUI

struct HelpMenu: View {
    var body: some View {
        VStack {
            VStack {
                Text("High Card")
                HStack {
                    CardView(card: .eagle)
                }
            }
        }
    }
}

#Preview {
    HelpMenu()
}
