//
//  FavoriteViewController.swift
//  MusicTop
//
//  Created by Consultant on 7/24/22.
//
import UIKit

class FavoriteViewController: UIViewController {

    lazy var albumTableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.backgroundColor = .black
        table.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.reuseID)
        return table
    }()
    
    
    let musicVM = MusicViewModel (networkManager: NetworkManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        view.backgroundColor = .black
        
        self.setUpUI()
       
        self.musicVM.loadAlbum()
        
        self.musicVM.bind {
            DispatchQueue.main.async {
                self.albumTableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.musicVM.loadAlbum()
    }
    
    private func setUpUI() {
 
        self.title = "Favoutites"
        
        self.view.addSubview(self.albumTableView)
        
        self.albumTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        self.albumTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.albumTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.albumTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
       
    }

}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.musicVM.fOvarited?.count ?? -1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.reuseID, for: indexPath) as? FavoriteTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = .black
        cell.configure(musicVm: musicVM, index: indexPath.row)
        
        return cell
    }
    
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController(musicVM: self.musicVM, index: indexPath.row)
        self.navigationController?.pushViewController(vc, animated: true)
       
    }
}
