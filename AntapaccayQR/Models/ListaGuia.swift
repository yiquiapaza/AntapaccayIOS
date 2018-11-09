//
//  ListaGuia.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/9/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import Foundation

class ListaGuia {
    private var id: String
    private var rowVersion: String
    private var numeroGuia: String
    init() {
        self.id = VACIO
        self.rowVersion = VACIO
        self.numeroGuia = VACIO
    }
    
    func setId(id: String) -> Void {
        self.id = id
    }
    func getId() -> String {
        return self.id
    }
    
    func setRowVersion(rowVersion: String) -> Void {
        self.rowVersion = rowVersion
    }
    func getRowVersion() -> String {
        return self.rowVersion
    }
    
    func setNumeroGuia(numeroGuia: String) -> Void {
        self.numeroGuia = numeroGuia
    }
    func getNumeroGuia() -> String {
        return self.numeroGuia
    }
}
