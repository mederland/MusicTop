//
//  AlbumViewModel.swift
//  MusicTop
//
//  Created by Consultant on 7/24/22.
//

import Foundation

protocol MusicViewModelCore {
    func bind(updateHandler: @escaping () -> Void)
    func getAlbums()
}

protocol MusicViewModelAttributes{
    var count: Int { get }
    func albumTitle(for index: Int) -> String?
    func albumImage(for index: Int, completion: @escaping(Data?) -> Void)
    func artistName(for index: Int) -> String?
}

typealias MusicViewModelType = MusicViewModelCore & MusicViewModelAttributes

class MusicViewModel {
    private var artists: [Shark] = [] {
        didSet {
            self.updateHandler?()
        }
    }
    var fOvarited: [Favorited]? {
         didSet{
             self.updateHandler?()
         }
     }
    var database: CoreDataManager
    private var networkManager: NetworkService
    private var pageCount = 1
    private var  updateHandler: (() -> Void)?

    
    init(networkManager: NetworkService, database: CoreDataManager = CoreDataManager()) {
        self.networkManager = networkManager
        self.database = database
    }
}

extension MusicViewModel: MusicViewModelCore {
    func bind(updateHandler: @escaping () -> Void) {
        self.updateHandler = updateHandler
    }
        
    func getAlbums() {
        self.networkManager.getAlbum(url: NetworkParams.popularAlbums(self.pageCount).url) { (result: Result<MusicList ,NetworkError>) in
                    switch result {
                    case .success(let list):
                        self.pageCount += 1
                        self.artists.append(contentsOf: list.feed.results)
                    case .failure(let error):
                        print(error)
                    }
                }
    }
    func makeAlbum(index: Int) {
        
        self.database.makeAlbum(musicVM: self, index: index)
       
    }
    
    func loadAlbum() {
        fOvarited = self.database.fetchAlbum()
    }

    func deleteAlbum(index: Int) {
        
        guard let f1 = self.fOvarited else { return }
        
        self.database.removeAlbum(f1[index])
        self.loadAlbum()
    }
}

extension MusicViewModel: MusicViewModelAttributes {
    var count: Int {
        return self.artists.count
    }
    func artistName(for index: Int) -> String? {
        guard index < self.count else {return nil}
        return self.artists[index].artistName
    }
    func albumTitle(for index: Int) -> String? {
        guard index < self.count else {return nil}
        return self.artists[index].name
    }
            func albumImage(for index: Int, completion: @escaping (Data?) -> Void) {
                    guard index < self.count else {
                        completion(nil)
                            return
        }
    let artworkUrl100 = self.artists[index].artworkUrl100
        
        if let imageData = ImageCache.shared.getImageData(key: artworkUrl100){
            completion(imageData)
            print("image")
            return
        }
        self.networkManager.getRawData(url: NetworkParams.albumImage(artworkUrl100).url){ Result in switch Result {
        case .success(let imageData):
            ImageCache.shared.setImageData(data: imageData, key: artworkUrl100)
            completion(imageData)
        case .failure(let error):
            print(error)
        }
        }
    }
}
//MusicViewModelType
