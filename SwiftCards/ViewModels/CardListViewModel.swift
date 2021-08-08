//
//  CardListViewModel.swift
//  SwiftCards
//
//  Created by Ibragim Akaev on 08/08/2021.
//

import Combine

final class CardListViewModel: ObservableObject {
    @Published var cardRepository = CardRepository()
    @Published var cardsViewModel: [CardViewModel] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        cardRepository.$swiftCards
            .map { swiftCards in
                swiftCards.map(CardViewModel.init)
            }
            .assign(to: \.cardsViewModel, on: self)
            .store(in: &cancellables)
    }
    
    func add(_ swiftCard: SwiftCard) {
        cardRepository.add(swiftCard)
    }
    
    func remove(_ swiftCard: SwiftCard) {
        cardRepository.remove(swiftCard)
    }
    
    func update(_ swiftCard: SwiftCard) {
        cardRepository.update(swiftCard)
    }
}
