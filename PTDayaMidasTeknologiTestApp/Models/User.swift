//
//  User.swift
//  PTDayaMidasTeknologiTestApp
//
//  Created by Jonathan Andryana on 07/03/23.
//

import Foundation

struct User:Codable {
    let id: Int
    let username: String
    let email: String
    let role: Bool
    let password: String
}
