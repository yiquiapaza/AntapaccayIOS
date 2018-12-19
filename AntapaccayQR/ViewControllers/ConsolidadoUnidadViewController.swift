//
//  ConsolidadoUnidadViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/26/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSpinner
import PMAlertController

class ConsolidadoUnidadViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var listaPaletas  = Array<Unidad>()
    let cellReuseIdentifier = "cell"
    @IBOutlet weak var unidades: UITextField!
    
    @IBOutlet weak var tablaPaleta: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tablaPaleta.delegate = self
        self.tablaPaleta.dataSource = self
        self.tablaPaleta.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    
    @IBAction func getUnidades(_ sender: Any) {
        
        var parametres = Parameters()
        
        if QR_CONST_PALETA == VACIO {
            parametres = [
                "Logical": "AND",
                "PropertyName": "codigo",
                "Value": unidades.text!,
                "Operator": "Equals"
            ]
        }
        else{
            unidades.text = QR_CONST_PALETA
            parametres = [
                "Logical":"AND",
                "PropertyName": "Id",
                "Value": unidades.text!,
                "Operator": "Equals"
            ]
        }
        
        if unidades.text! == VACIO {
            let alertBulto = PMAlertController(title: "Ingrese un codigo de una Paleta", description: "Es un campo Obligatorio", image: UIImage(named: "precaucion"), style: .alert)
            alertBulto.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
            self.present(alertBulto, animated: true, completion: nil)
        }
        else {
            self.delay(secons: 3.0, completatio: {
                SwiftSpinner.show("Verificando API")
                Alamofire.request(BUSQUEDA_PALETA_BY_ID, method: .post, parameters: parametres, encoding: JSONEncoding.default)
                    .responseJSON() {
                        response in switch response.result{
                        case .success:
                            let paletas = response.result.value as! [Dictionary<String, AnyObject>]
                            if paletas.isEmpty {
                                let alertOrden = PMAlertController(title: "Error", description: "Numero de Paleta erroneo", image: UIImage(named: "error"), style: .alert)
                                alertOrden.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
                                self.present(alertOrden, animated: true, completion: nil)
                                SwiftSpinner.hide()
                            }
                            else {
                                for item in paletas{
                                    let paleta = Unidad()
                                    paleta.setId(id: item["Id"] as! String)
                                    paleta.setIdAlmacenRecepcion(idAlmacenRecepcion: item["idAlmacenRecepcion"] as! String)
                                    paleta.setIdTransporteConsolidado(idTransporteConsolidado: CONST_ID)
                                    paleta.setNumeroPaleta(numeroPaleta: item["numeroPaleta"] as! String)
                                    paleta.setCodigo(codigo: item["codigo"] as! String)
                                    paleta.setCodigoQR(codigoQR: item["codigoQR"] as! String)
                                    paleta.setNumeroWaybill(numeroWaybill: item["numeroWaybill"] as! String)
                                    paleta.setPeso(peso: item["peso"] as! Float)
                                    paleta.setAlto(alto: item["alto"] as! Float)
                                    paleta.setLargo(largo: item["largo"] as! Float)
                                    paleta.setAncho(ancho: item["ancho"] as! Float)
                                    paleta.setFragil(fragil: item["fragil"] as! Bool)
                                    paleta.setSobredimensionado(sobredimensionado: item["sobredimensionado"] as! Bool)
                                    paleta.setCargaPeligrosa(cargaPeligrosa: item["cargaPeligrosa"] as! Bool)
                                    paleta.setImportacion(importacion: item["importacion"] as! Bool)
                                    paleta.setNacional(nacional: item["nacional"] as! Bool)
                                    paleta.setFechaRecepcion(fechaRecepcion: item["fechaRecepcion"] as! Int)
                                    paleta.setIdDiscrepancia(idDiscrepancia: item["idDiscrepancia"] as! String)
                                    paleta.setCampoDiscrepancia(campoDiscrepancia: item["campoDiscrepancia"] as! String)
                                    paleta.setImagenes(imagenes: item["imagenes"] as? String ?? "")
                                    paleta.setRowVersion(rowVersion: item["RowVersion"] as! String)
                                    
                                    paleta.setCodigoTransportista(codigoTransportista: item["codigoTransportista"] as! String)
                                    paleta.setTransportista(transportista: item["transportista"] as! String)
                                    
                                    self.listaPaletas.append(paleta)
                                    SwiftSpinner.hide()
                                }
                            }
                            self.tablaPaleta.reloadData()
                            self.unidades.text = ""
                        case .failure(let error):
                            print(error)
                            SwiftSpinner.hide()
                        }
                }
            })
        }
    }
    
    func delay(secons:Double, completatio: @escaping () -> ()) -> Void {
        let popTIme = DispatchTime.now() + Double(Int64(Double(NSEC_PER_SEC) * secons))/Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: popTIme){
            completatio()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaPaletas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tablaPaleta.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = listaPaletas[indexPath.row].getNumeroPaleta()
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is TabBarUnidadViewController{
            let vs = segue.destination as? TabBarUnidadViewController
            vs!.listaPaletas = self.listaPaletas
        }
    }
    
}
