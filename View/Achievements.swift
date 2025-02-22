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
                
                VStack {
                    Achievement(id: 1, title: "Dedication is Key", description: "Play 30 hands", value: pokerEngine.handsPlayed, total: 1, reward: 40)
                    
                    Achievement(id: 2, title: "A Master of Sorts", description: "Win 20 Hands", value: pokerEngine.won, total: 20, reward: 60)
                    
                    Achievement(id: 3, title: "Big Brain", description: "Answer 10 trivia questions correctly", value: pokerEngine.correctTriviaQuestions, total: 10, reward: 30)
                }
                .padding()
            }
            
        }
    }
    
    func Achievement(id: Int, title: String, description: String, value: UInt, total: UInt, reward: UInt) -> some View {
        HStack {
            @State var claimed = false
            VStack(alignment: .leading) {
                
                HStack {
                    Image(systemName: value >= total ? "checkmark.circle.fill" : "circle")
                        .font(.system(size: 30))
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.custom("Mayan", size: 30))
                            .foregroundStyle(.white)
                        Text(description)
                            .font(.custom("Mayan", size: 20))
                            .foregroundStyle(.white)
                    }
                }
                ProgressView(value: Double(value), total: Double(total))
                    .tint(Color("Base"))
            }
            .foregroundStyle(Color("Base"))
            
            Button(action: {
                pokerEngine.achievementsClaimed.append(id)
                pokerEngine.rewardPlayer(reward)
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black.opacity(0.5), lineWidth: 5)
                        .fill(Color(value < total || pokerEngine.achievementsClaimed.contains(id) ? "Trees" : "TreesLight"))
                    HStack {
                        Text("+")
//                            .font(.custom("Mayan", size: 20))
                            .foregroundStyle(.white)
                        Token(description: (text: nil, amount: 5, number: true))
                            .scaleEffect(0.4)
                    }
                }
                .frame(width: 120, height: 40)
            })
            .disabled(value < total || pokerEngine.achievementsClaimed.contains(id))
        }
        .padding(20)
        
    }
}
