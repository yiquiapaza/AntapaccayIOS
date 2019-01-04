//
//  standarTableViewCell.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 1/3/19.
//  Copyright © 2019 Innnovacis SRL. All rights reserved.
//

import UIKit

class standarTableViewCell: UITableViewCell {

    
    @IBOutlet weak var codigo: UILabel!
    @IBOutlet weak var proveedor: UILabel!
    @IBOutlet weak var almacen: UILabel!
    @IBOutlet weak var eliminar: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
