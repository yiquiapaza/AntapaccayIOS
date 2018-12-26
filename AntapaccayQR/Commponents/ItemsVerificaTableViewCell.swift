//
//  ItemsVerificaTableViewCell.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 12/26/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit

class ItemsVerificaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var buttonInConforme: UIButton!
    @IBOutlet weak var buttonConforme: UIButton!
    
    @IBOutlet weak var numeroItem: UILabel!
    @IBOutlet weak var descripcion: UILabel!
    @IBOutlet weak var cantidad: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
