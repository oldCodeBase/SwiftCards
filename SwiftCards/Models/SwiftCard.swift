//
//  SwiftCard.swift
//  SwiftCards
//
//  Created by Ibragim Akaev on 08/08/2021.
//

import FirebaseFirestoreSwift

struct SwiftCard: Identifiable, Codable {
    @DocumentID var id: String?
    var question: String
    var answer: String
    var passed: Bool = false
    
}
