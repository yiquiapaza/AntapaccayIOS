//
//  BultoComponentTableViewCell.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 12/12/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit

class BultoComponentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var quitarButton: UIButton!
    @IBOutlet weak var descripcionOrden: UILabel!
    @IBOutlet weak var numeroOrden: UILabel!
    @IBOutlet weak var numeroGuia: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
