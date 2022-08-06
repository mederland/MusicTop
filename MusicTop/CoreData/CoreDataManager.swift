//
//  DataManager.swift
//  MusicTop
//
//  Created by Consultant on 8/2/22.

import Foundation
import CoreData

class CoreDataManager {

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MusicTop")
        container.loadPersistentStores { (description, error) in
            if let _ = error {
                fatalError("Something went horribly wrong")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = self.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
 
    func fetchAlbum() -> [Favorited]? {
        let context = self.persistentContainer.viewContext
        
        let request: NSFetchRequest<Favorited> = Favorited.fetchRequest()
        
        do {
            let results = try context.fetch(request)
                return results
        } catch {
            print(error)
        }
        
        return nil
    }
 
    func makeAlbum(musicVM: MusicViewModel, index: Int) {
        let context = self.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Favorited", in: context) else { return }
        
        let favorited = Favorited(entity: entity, insertInto: context)
  
        favorited.title = (musicVM.artistName(for: index) ?? "")
        favorited.artist = (musicVM.albumTitle(for: index) ?? "")

        musicVM.albumImage(for: index) { imageData in
            guard let imageData = imageData else {
                return
            }

            DispatchQueue.main.async {
                favorited.image = imageData
            }
        }
       self.saveContext()
    }
    
    func removeAlbum(_ f1: Favorited) {
        let context = self.persistentContainer.viewContext
        context.delete(f1)
        self.saveContext()
        
    }
}
