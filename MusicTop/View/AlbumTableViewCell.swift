//
//  AlbumTableViewCell.swift
//  MusicTop
//
//  Created by Consultant on 7/24/22.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    var musicVm: MusicViewModel?
    var index: Int?
    
    static let reuseId = "\(AlbumTableViewCell.self)"
    
    lazy var albumImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "Apple_Music_Icon")
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.layer.borderWidth = 1.0
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
        }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 4
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "Artist Name"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var overviewLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "Album Name"
        label.textColor = .white
        label.textAlignment = .left
        label.backgroundColor = .clear
        
        return label
    }()
    
    lazy var favButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .red
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func buttonPressed(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            DispatchQueue.main.async {
                self.favButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            }
            musicVm?.makeAlbum(index: index ?? -1)
        }
        else {
            DispatchQueue.main.async {
                self.favButton.setImage(UIImage(systemName: "plus"), for: .normal)
            }
            guard let index = index else {
                return
            }
            musicVm?.deleteAlbum(index: index)
        }
    }
    
    
    private func setUpUI() {
        let hStack = UIStackView(axis: .horizontal, spacing: 8, distribution: .fillEqually)
        let vStack = UIStackView(axis: .vertical, spacing: 8, distribution: .fillEqually)
        let zStack = UIStackView(axis: .horizontal, spacing: -8, distribution: .fill)
        
        zStack.addArrangedSubview(self.favButton)

        vStack.addArrangedSubview(self.titleLabel)
        vStack.addArrangedSubview(self.overviewLabel)

        hStack.addArrangedSubview(self.albumImageView)
        
        hStack.addArrangedSubview(vStack)
        hStack.addArrangedSubview(zStack)

        
        self.contentView.addSubview(hStack)
        hStack.bindToSuperview()
    }

    func configure(musicVM: MusicViewModel, index: Int) {
            self.musicVm = musicVM
            self.index = index
            self.titleLabel.text = musicVM.albumTitle(for: index)
        self.overviewLabel.text = musicVM.artistName(for: index)
            musicVM.albumImage(for: index) { imageData in
                guard let imageData = imageData else { return }

                DispatchQueue.main.async {
                    self.albumImageView.image = UIImage(data: imageData)
                }
            }
        }
//    func configure (musicVM: MusicViewModelType, index: Int){
//        self.titleLabel.text = musicVM.artistName(for: index)
//        self.overviewLabel.text = musicVM.albumTitle(for: index)
//
//        musicVM.albumImage(for: index) {
//            imageData in
//            guard let imageData = imageData else {return}
//            DispatchQueue.main.async {
//                self.albumImageView.image = UIImage(data: imageData)
//            }
//        }
//    }
}
