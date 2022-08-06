//
//  DetailViewController.swift
//  MusicTop
//
//  Created by Consultant on 8/2/22.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    lazy var albumImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Image")
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        return imageView
    }()

    lazy var albumName: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Album Title"
        label.layer.borderWidth = 2.0
        label.layer.cornerRadius = 8
        
        return label
    }()
    
    lazy var artistName: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Artist Name"
        label.layer.borderWidth = 2.0
        label.layer.cornerRadius = 8
        
        return label
    }()
   
    lazy var releaseDate: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Release Date"
        label.layer.borderWidth = 2.0
        label.layer.cornerRadius = 8

        return label
    }()

    lazy var albumGenre: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Genre"
        label.layer.borderWidth = 2.0
        label.layer.cornerRadius = 8

        return label
    }()
    
    var musicVM = MusicViewModel(networkManager: NetworkManager())
    var index: Int
    
    init(musicVM: MusicViewModel, index: Int){
        self.musicVM = musicVM
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func tapAlbumDetail() {
        self.albumName.text = " Album: \(musicVM.albumTitle(for: index) ?? "")"
        self.artistName.text = " Artist: \(musicVM.artistName(for: index) ?? "")"
        musicVM.albumImage(for: index) { imageData in
            guard let imageData = imageData else { return }
            
            DispatchQueue.main.async {
                self.albumImage.image = UIImage(data: imageData)
            }
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        
        self.view.backgroundColor = .black
        self.navigationItem.title = "Album Details"
        tapAlbumDetail()
    }
    
    private func setUpUI() {
        
        let hStack = UIStackView(axis: .horizontal, spacing: 8, distribution: .fillProportionally)
        let vStack = UIStackView(axis: .vertical, spacing: 8, distribution: .fillProportionally)

        vStack.addArrangedSubview(self.releaseDate)
        vStack.addArrangedSubview(self.albumName)
        vStack.addArrangedSubview(self.artistName)
        vStack.addArrangedSubview(self.albumGenre)
        hStack.addArrangedSubview(self.albumImage)
        
        hStack.addArrangedSubview(vStack)
        hStack.bindToSuperview()
    }
}
 

