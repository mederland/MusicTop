//
//  ViewController.swift
//  MusicTop
//
//  Created by Consultant on 7/23/22.
//
import UIKit

class ViewController: UITabBarController {
    let musicVM: MusicViewModelType
    
    init(vm: MusicViewModelType){
        self.musicVM = vm
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        var _: [UINavigationItem.LargeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode]
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        let AVC = AlbumViewController()
        let navigationAVC = UINavigationController(rootViewController: AVC)
        navigationAVC.navigationBar.prefersLargeTitles = true
        title = "Album"

        let FVC = FavoriteViewController()
        let navigationFVC = UINavigationController(rootViewController: FVC)
        navigationFVC.navigationBar.prefersLargeTitles = true
        title = "Favorite"
        
        self.setViewControllers([AVC,FVC], animated: true)
        
        guard let items = self.tabBar.items else {
            return
        }
                let images = [ "rectangle.stack", "hand.thumbsup"]
                for x in 0..<items.count {
                    items[x].image = UIImage(systemName: images[x])
                }
        
        self.tabBar.backgroundColor = .black
        self.tabBar.tintColor = .red
        self.tabBar.unselectedItemTintColor = .white
    }
}
