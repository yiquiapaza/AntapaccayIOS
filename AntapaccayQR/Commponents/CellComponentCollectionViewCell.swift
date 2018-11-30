//
//  CellComponentCollectionViewCell.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/30/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit

class CellComponentCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var viewCollection: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameImage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
