//
//  AlbumViewController.swift
//  MusicTop
//
//  Created by Consultant on 7/24/22.
//

import UIKit

class AlbumViewController: UIViewController, UITableViewDataSource {

    
    lazy var albumTable: UITableView = {
         let table = UITableView(frame: .zero)
         table.translatesAutoresizingMaskIntoConstraints = false
         table.dataSource = self
         table.delegate = self
         table.backgroundColor = .black
         table.register(AlbumTableViewCell.self, forCellReuseIdentifier: AlbumTableViewCell.reuseId)
         return table
     }()
    
    let musicVM: MusicViewModelType = MusicViewModel(networkManager: NetworkManager())
    
override func viewDidLoad() {
    super.viewDidLoad()
    self.setUpUI()
    view.backgroundColor = .systemBackground
    title = "Album"
    let AVC = AlbumViewController()
    let navigationAVC = UINavigationController(rootViewController: AVC)
    navigationAVC.navigationBar.prefersLargeTitles = true
    
    
    self.musicVM.bind {
        DispatchQueue.main.async {
            self.albumTable.reloadData()
        }
    }
    self.musicVM.getAlbums()
}
    private func setUpUI() {
        self.view.addSubview(self.albumTable)
        self.albumTable.bindToSuperview()
    }

}

extension AlbumViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.musicVM.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.reuseId, for: indexPath) as? AlbumTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(musicVM: self.musicVM as! MusicViewModel, index: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController(musicVM: self.musicVM as! MusicViewModel, index: indexPath.row)
    self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension AlbumViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPath: [IndexPath]) {
        let lastIndexPath = IndexPath(row: self.musicVM.count - 1, section: 0)
        guard indexPath.contains(lastIndexPath) else {return}
        self.musicVM.getAlbums()
    }
}
