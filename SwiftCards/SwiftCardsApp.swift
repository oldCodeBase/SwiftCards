//
//  SwiftCardsApp.swift
//  SwiftCards
//
//  Created by Ibragim Akaev on 08/08/2021.
//

import SwiftUI
import Firebase

@main
struct SwiftCardsApp: App {
    init() { FirebaseApp.configure() }
    
    var body: some Scene {
        WindowGroup {
            CardListView(cardListViewModel: CardListViewModel())
        }
    }
}
