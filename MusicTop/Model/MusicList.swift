//
//  MusicList.swift
//  MusicTop
//
//  Created by Consultant on 7/23/22.
//

import Foundation

struct MusicList: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let results: [Shark]
}

struct Shark: Decodable {
    let artistName: String//name artist
    let name: String //album name
    let releaseDate: String//date
    let artworkUrl100: String//image
    let genres: [Genre] //Genre
}

struct Genre: Decodable {
    let name: String
}
