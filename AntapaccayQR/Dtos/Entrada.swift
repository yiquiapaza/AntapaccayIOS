//
//  Entrada.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/28/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import Foundation

class Entrada {
    private var numeroGuia : String
    private var almacenDestino : String
    private var puntoPartida : String
    private var numero_guia : String
    private var numero_transporte : String
    init() {
        self.numeroGuia = VACIO
        self.almacenDestino = VACIO
        self.puntoPartida  = VACIO
        self.numero_guia = VACIO
        self.numero_transporte = VACIO
    }
    func setNumeroGuia(numeroGuia : String) -> Void {
        self.numeroGuia = numeroGuia
    }
    func getNumeroGuia() -> String {
        return self.numeroGuia
    }
    
    func setAlmacenDestino(almacenDestino : String) -> Void {
        self.almacenDestino = almacenDestino
    }
    func getAlmacenDestino() -> String {
        return self.almacenDestino
    }
    
    func setPuntoPartida(puntoPartida : String) -> Void {
        self.puntoPartida = puntoPartida
    }
    func getPuntoPartida() -> String {
        return self.puntoPartida
    }
    
    func setNumero_Guia(numero_guia : String) -> Void {
        self.numero_guia = numero_guia
    }
    func getNumero_Guia() -> String {
        return self.numero_guia
    }
    
    func setNumero_Transporte(numero_transporte : String) -> Void {
        self.numero_transporte = numero_transporte
    }
    func getNumero_Transporte() -> String {
        return self.numero_transporte
    }
}
