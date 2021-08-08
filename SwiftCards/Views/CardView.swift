//
//  CardView.swift
//  SwiftCards
//
//  Created by Ibragim Akaev on 08/08/2021.
//

import SwiftUI

struct CardView: View {
    @State private var flipped = false
    var cardViewModel: CardViewModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(withAnimation(.easeInOut(duration: 4).speed(5), {
                flipped ? Color.green : Color.accentColor
            }))
            .frame(height: withAnimation(.easeInOut(duration: 4).speed(5), {
                flipped ? 200 : 100
            }))
            .overlay(
                ZStack {
                    HStack {
                        Spacer()
                        VStack {
                            Image(systemName: cardViewModel.swiftCard.passed ? "checkmark.circle.fill" : "checkmark.circle")
                                .foregroundColor(.red)
                            Spacer()
                        }
                    }
                    Text(flipped ? cardViewModel.swiftCard.answer : cardViewModel.swiftCard.question)
                        .frame(alignment: flipped ? .leading : .center)
                }.padding()
            ).onTapGesture {
                withAnimation {
                    flipped.toggle()
                }
            }
    }
}
