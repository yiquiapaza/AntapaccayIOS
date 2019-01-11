//
//  GuiaComponentTableViewCell.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 1/11/19.
//  Copyright © 2019 Innnovacis SRL. All rights reserved.
//

import UIKit

class GuiaComponentTableViewCell: UITableViewCell {

    @IBOutlet weak var numeroGuia: UILabel!
    
    @IBOutlet weak var guardarImagen: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
