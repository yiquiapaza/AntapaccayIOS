//
//  TerminarViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/7/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit

class TerminarViewController: UIViewController {
    
    var objectoCarga = Array<Item>()
    
    override func viewDidLoad() {
        
        let data = self.parent as! TabBarViewController
        self.objectoCarga =  data.objetoCarga
        
        for item in self.objectoCarga {
            print(item.getCantidad())
        }
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func terminar(_ sender: UIButton) {
        let bulto = Bulto()
        bulto.setIdAlmacenRecepcion(idAlmacenRecepcion: "")
        bulto.setAlmacenDestino(almacenDestino: "")
        bulto.setNombreProveedor(nombreProveedor: "")
        bulto.setNombreAlmacen(nombreAlmacen: "")
        bulto.setTipoOrden(tipoOrden: "esto desde la primera vista")
        bulto.setValorOrden(valorOrden: "esto desde la primera vista")
        bulto.setEstadoBulto(estadoBulto: "1")
        bulto.setPeso(peso: PESO)
        bulto.setAlto(alto: ALTO)
        bulto.setAncho(ancho: ANCHO)
        bulto.setLargo(largo: LARGO)
        bulto.setFragil(fragil: FRAGIL)
        bulto.setsobredimensionado(sobredimensionamiento: SOBREDIMENSIONADO)
        bulto.setCargaPeligrosa(cargaPeligrosa: CARGA_PELIGROSA)
        bulto.setImportacion(importacion: IMPORTACION)
        bulto.setNacional(nacional: NACIONAL)
        bulto.setFechaRecepcion(fechaRecepcion: Calendar.current.component(.year, from: Date()))
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
