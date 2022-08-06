//
//  NetworkParams.swift
//  MusicTop
//
//  Created by Consultant on 7/23/22.
//

import Foundation

enum NetworkParams {
    
    private struct NetworkConstants {
        static let popularBase = "https://rss.applemarketingtools.com/api/v2/us/music/most-played/100/albums.json"
        static let baseImage = "https://"
        static let key = "is5-ssl.mzstatic.com/image/thumb/Music112/v4/3e/04/eb/3e04ebf6-370f-f59d-ec84-2c2643db92f1/196626945068.jpg/500x500bb.jpg"
    }
    
    
    case popularAlbums(Int)
    case albumImage(String)
    
    var url: URL? {
        switch self {
        case .popularAlbums(let page):
            var component = URLComponents(string: NetworkConstants.popularBase)
            component?.queryItems = [URLQueryItem(name: "api_key", value: NetworkConstants.key),
                                     URLQueryItem(name: "language", value: "us"),
                                     URLQueryItem(name: "page", value: "\(page)")]
            return component?.url
        case .albumImage(let posterPath):
//            return URL(string: NetworkConstants.baseImage + posterPath)
            let baseURL = URL(string: NetworkConstants.baseImage)
            return URL(string: posterPath, relativeTo: baseURL)
        }
    }
    
}


// 500x500bb.jpg
