//
//  Albums.swift
//  PTDayaMidasTeknologiTestApp
//
//  Created by Jonathan Andryana on 07/03/23.
//

import Foundation

struct AlbumsResponse: Codable{
    let albums: [Album]
}

struct Album:Codable {
    let albumId: Int
    let id: Int
    let title : String
    let url : String
    let thumbnailUrl: String
}
