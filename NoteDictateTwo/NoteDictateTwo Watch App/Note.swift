//
//  Note.swift
//  NoteDictateTwo Watch App
//
//  Created by Mateusz Brychczynski on 07/06/2023.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    let text: String
}
