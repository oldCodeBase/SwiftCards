//
//  FormView.swift
//  SwiftCards
//
//  Created by Ibragim Akaev on 08/08/2021.
//

import SwiftUI

struct FormView: View {
    @State private var question = ""
    @State private var answer = ""
    var didAddCard: (_ swiftCard: SwiftCard) -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Question", text: $question)

                    if answer == "" {
                        TextField("Answer", text: $answer)
                    } else {
                        TextEditor(text: $answer)
                    }
                }
                
                Button("Create card") {
                    let card = SwiftCard(question: question, answer: answer)
                    didAddCard(card)
                }.disabled(question.isEmpty || answer.isEmpty).padding()
                
            }.navigationTitle("New Card")
        }
    }
}
