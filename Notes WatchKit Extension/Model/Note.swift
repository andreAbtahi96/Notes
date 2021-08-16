//
//  Note.swift
//  Notes WatchKit Extension
//
//  Created by Andre Abtahi on 8/15/21.
//

import Foundation

struct Note: Identifiable, Codable{
    let id: UUID
    let text: String
}
