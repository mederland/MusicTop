//
//  FavoriteTableViewCell.swift
//  MusicTop
//
//  Created by Consultant on 8/2/22.
//
import Foundation
import UIKit


class FavoriteTableViewCell: UITableViewCell {
    
    var musicVM: MusicViewModel?
    var index: Int?
    
    static let reuseID = "\(FavoriteTableViewCell.self)"

    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "poster")
        imageView.layer.cornerRadius = 25.0
     return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Album Name"
        return label
    }()
    
    lazy var artistLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Artist Name"
        return label
    }()
    
//    lazy var favButton: UIButton = {
//        let button = UIButton(frame: .zero)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setImage(UIImage(systemName: "plus"), for: .normal) // "checkmark"
//
//        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
//        return button
//    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    @objc func buttonPressed(sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//
//        if sender.isSelected {
//            DispatchQueue.main.async {
//                self.favButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
//            }
//            musicVM?.makeAlbum(index: index ?? -1)
//        }
//        else {
//            DispatchQueue.main.async {
//                self.favButton.setImage(UIImage(systemName: "plus"), for: .normal)
//            }
//            guard let index = index else {
//                return
//            }
//            musicVM?.deleteAlbum(index: index)
//        }
//    }
    
    private func setUpUI() {
        
        let hStack = UIStackView(axis: .horizontal, spacing: 8, distribution: .fillEqually)
        let vStack = UIStackView(axis: .vertical, spacing: 8, distribution: .fillEqually)
        let zStack = UIStackView(axis: .horizontal, spacing: -8, distribution: .fill)
//        zStack.addArrangedSubview(self.favButton)
        vStack.addArrangedSubview(self.titleLabel)
        vStack.addArrangedSubview(self.artistLabel)
        
        hStack.addArrangedSubview(self.posterImageView)
        hStack.addArrangedSubview(vStack)
        hStack.addArrangedSubview(zStack)
        
        self.contentView.addSubview(hStack)
        hStack.bindToSuperview()
    }
    

    func configure(musicVm: MusicViewModel, index: Int) {
        self.musicVM = musicVm
        self.index = index
    
        self.titleLabel.text = musicVM?.fOvarited?[index].artist
        self.artistLabel.text = musicVM?.fOvarited?[index].title
        
        guard let img = musicVM?.fOvarited?[index].image else {return}
        self.posterImageView.image = UIImage(data: img)
        
    }
}

