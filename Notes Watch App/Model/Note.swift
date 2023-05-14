//
//  Note.swift
//  Notes Watch App
//
//  Created by Jadoul Nicolas on 13/05/2023.
//

import Foundation

struct Note: Identifiable, Encodable, Decodable, Equatable {
    let id : UUID
    let text: String
}
