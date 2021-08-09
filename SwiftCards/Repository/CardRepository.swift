//
//  CardRepository.swift
//  SwiftCards
//
//  Created by Ibragim Akaev on 08/08/2021.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

final class CardRepository: ObservableObject {
    
    @Published var swiftCards: [SwiftCard] = []
    private let store = Firestore.firestore()
    private let path = "SwiftCard"
    
    init() { get() }
    
    private func get() {
        store.collection(path).addSnapshotListener { snapshot, error in
            if let error = error {
                print(error)
                return
            }
            self.swiftCards = snapshot?.documents.compactMap {
                try? $0.data(as: SwiftCard.self)
            } ?? []
        }
    }
    
    func add(_ swiftCard: SwiftCard) {
        do {
            _ = try store.collection(path).addDocument(from: swiftCard)
        } catch {
            fatalError("Adding swift card failed")
        }
    }
    
    func remove(_ swiftCard: SwiftCard) {
        guard let documentId = swiftCard.id else { return }
        store.collection(path).document(documentId).delete() { error in
            if let error = error {
                print("Unable to remove card, error: \(error.localizedDescription)")
            }
        }
    }
    
    func update(_ swiftCard: SwiftCard) {
        guard let documentId = swiftCard.id else { return }
        do {
            _ = try store.collection(path).document(documentId).setData(from: swiftCard)
        } catch {
            fatalError("Updating swift card failed")
        }
    }
}
