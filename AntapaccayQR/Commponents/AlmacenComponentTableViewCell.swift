//
//  AlmacenComponentTableViewCell.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 12/6/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit

class AlmacenComponentTableViewCell: UITableViewCell {

    @IBOutlet weak var buttonConfirm: UIButton!
    @IBOutlet weak var numeroItem: UILabel!
    @IBOutlet weak var numeroProducto: UILabel!
    @IBOutlet weak var nombreProveedor: UILabel!
    @IBOutlet weak var nombreAlmacen: UILabel!
    @IBOutlet weak var nombreTransporte: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
