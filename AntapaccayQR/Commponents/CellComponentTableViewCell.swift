//
//  CellComponentTableViewCell.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 12/5/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit

class CellComponentTableViewCell: UITableViewCell {

    
    @IBOutlet weak var numeroItem: UILabel!
    @IBOutlet weak var fechaRegistro: UILabel!
    @IBOutlet weak var nombrePreveedor: UILabel!
    @IBOutlet weak var fechaRecepcion: UILabel!
    @IBOutlet weak var solicitado: UILabel!
    @IBOutlet weak var recibido: UILabel!
    @IBOutlet weak var descripcion: UILabel!
    
    @IBOutlet weak var limaLlegada: UILabel!
    @IBOutlet weak var arequipaLlegada: UILabel!
    @IBOutlet weak var arequipaPartida: UILabel!
    @IBOutlet weak var minaLlegada: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
