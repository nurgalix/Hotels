//
//  MainCollectionViewCell.swift
//  Hotels
//
//  Created by Nurgali on 24.01.2024.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        
        // Deactivate existing constraints if any
        image.translatesAutoresizingMaskIntoConstraints = false
        //            NSLayoutConstraint.deactivate(image.constraints)
        
        
        //            NSLayoutConstraint.activate([
        //                image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        //                image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        //                image.topAnchor.constraint(equalTo: contentView.topAnchor),
        //                image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        //            ])
    }
    
    
    
}
