//
//  ContentView.swift
//  SwiftCards
//
//  Created by Ibragim Akaev on 08/08/2021.
//

import SwiftUI

struct CardListView: View {
    @ObservedObject var cardListViewModel: CardListViewModel
    @State private var showingForm = false
    @State private var showPassed = false
    
    var body: some View {
        NavigationView {
            VStack {
                Toggle(isOn: $showPassed) {
                    Text("\(showPassed ? "Hide" : "Show") passed questions")
                }.padding(.horizontal, 20)
                List {
                    ForEach(cardListViewModel.cardsViewModel.filter {
                                $0.swiftCard.passed == showPassed}) { cardVM in
                        CardView(cardViewModel: cardVM)
                            .onLongPressGesture(minimumDuration: 1.5) {
                                var swiftCard = cardVM.swiftCard
                                swiftCard.passed.toggle()
                                cardListViewModel.update(swiftCard)
                            }
                    }.onDelete(perform: delete)
                }.listStyle(InsetListStyle())
                Button(action: {
                    showingForm = true
                }) {
                    Circle()
                        .fill(Color.green)
                        .frame(height: 60)
                        .overlay(Image(systemName: "plus").foregroundColor(.white))
                }.sheet(isPresented: $showingForm) {
                    FormView { (swiftCard) in
                        cardListViewModel.add(swiftCard)
                        showingForm = false
                    }
                }
            }
            
            .navigationTitle("Swift Cards")
        }
    }
    
    private func delete(at offsets: IndexSet) {
        offsets.map { cardListViewModel.cardsViewModel[$0].swiftCard }.forEach(cardListViewModel.remove)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CardListView(cardListViewModel: CardListViewModel())
    }
}
