//
//  ReporteUserViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 12/5/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit
import Alamofire

class ReporteUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
   
    @IBOutlet weak var tableReporte: UITableView!
    var listaReporte = Array<Reporte>()
    let cellReuseIdentifier = "cell"

    @IBOutlet weak var numeroGuia: UITextField!
    
    override func viewDidLoad() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cerrar Session", style: .plain, target: self, action: #selector(cerrarSession))
        tableReporte.delegate = self
        tableReporte.dataSource = self
        tableReporte.register(UINib(nibName: "CellComponentTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        super.viewDidLoad()
    }
    
    @IBAction func obtenerData(_ sender: UIButton) {
        
        Alamofire.request(OBTENER_GUIAS, method: .post, parameters: ["valorOrden": self.numeroGuia.text!], encoding: JSONEncoding.default)
            .responseJSON(){
                response in switch response.result{
                case .success(let data):
                    let outList = data as! [Dictionary<String,AnyObject>]
                    for item in outList{
                        let salida = Reporte()
                        salida.setNumeroItem(numeroItem: item["numeroItem"] as! String)
                        salida.setCantidad(cantidad: String(item["cantidad"] as! Int))
                        salida.setCantidadPO(cantidadPO: String(item["cantidadPO"] as! Int))
                        salida.setNombreProveedor(nombreProveedor: item["nombreProveedor"] as! String)
                        salida.setDescripcion(descripcion: item["descripcion"] as? String ?? "")
                        salida.setFechaRecepcion(fechaRecepcion: item["fechaRecepcion"] as! Int)
                        salida.setFechaTentativaFin(fechaTentativaFin: item["fechaTentativaFin"] as! Int)
                        salida.setSalidaLima(salidaLima: item["salidaLima"] as! Int)
                        salida.setLlegadaAqp(llegadaAqp: item["llegadaAqp"] as! Int)
                        salida.setSalidaAqp(salidaAqp: item["salidaAqp"] as! Int)
                        salida.setLlegadaMina(llegadaMina: item["llegadaMina"] as! Int)
                        salida.setEstado(estado: item["ESTADO"] as! Bool)
                        salida.setDisponibilidad(disponibilidad: item["DISPONIBILIDAD"] as! Bool)
                        self.listaReporte.append(salida)
                    }
                    self.tableReporte.reloadData()
                    print(data)
                case .failure(let error):
                    print(error)
                }
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listaReporte.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.locale = NSLocale(localeIdentifier: "es_PE") as Locale
        let cell = self.tableReporte.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellComponentTableViewCell
        if (self.listaReporte[indexPath.row].getLlegadaMina() == 0 && self.listaReporte[indexPath.row].getSalidaLima() == 0 && self.listaReporte[indexPath.row].getSalidaAqp() == 0 && self.listaReporte[indexPath.row].getSalidaLima() == 0 ){
            cell.limaLlegada?.text = "No Registrada"
            cell.arequipaLlegada?.text = "No Registrada"
            cell.arequipaPartida?.text = "No Registrada"
            cell.minaLlegada?.text = "No Registrada"
            cell.numeroItem.backgroundColor = UIColor.red
            cell.fechaRegistro?.text = "X No Regitrada"
        }
        else if (self.listaReporte[indexPath.row].getLlegadaMina() == 0){
            cell.numeroItem.backgroundColor = UIColor.yellow
            let sLima = NSDate(timeIntervalSince1970: TimeInterval(self.listaReporte[indexPath.row].getSalidaLima())/1000.0)
            let lAqp = NSDate(timeIntervalSince1970: TimeInterval(self.listaReporte[indexPath.row].getLlegadaAqp())/1000.0)
            let sAqp = NSDate(timeIntervalSince1970: TimeInterval(self.listaReporte[indexPath.row].getSalidaAqp())/1000.0)
            cell.limaLlegada?.text = formatter.string(from: sLima as Date)
            cell.arequipaLlegada?.text = formatter.string(from: lAqp as Date)
            cell.arequipaPartida?.text = formatter.string(from: sAqp as Date)
            cell.minaLlegada?.text = "No Registrada"
            var fecha = (self.listaReporte[indexPath.row].getSalidaLima() > self.listaReporte[indexPath.row].getLlegadaAqp()) ? self.listaReporte[indexPath.row].getSalidaLima() : self.listaReporte[indexPath.row].getLlegadaAqp()
            fecha = (self.listaReporte[indexPath.row].getSalidaAqp() > fecha) ? self.listaReporte[indexPath.row].getSalidaAqp() : fecha
            let _fechaDouble = Double(fecha)
            let _fecha = NSDate(timeIntervalSince1970: TimeInterval( _fechaDouble/1000.0))
            cell.fechaRegistro?.text = formatter.string(from: _fecha as Date)
            
        }
        else if(self.listaReporte[indexPath.row].getLlegadaMina() != 0 && self.listaReporte[indexPath.row].getSalidaLima() != 0 && self.listaReporte[indexPath.row].getSalidaAqp() != 0 && self.listaReporte[indexPath.row].getSalidaLima() != 0 ) {
            cell.numeroItem.backgroundColor = UIColor.green
            let sLima = NSDate(timeIntervalSince1970: TimeInterval(self.listaReporte[indexPath.row].getSalidaLima())/1000.0)
            let lAqp = NSDate(timeIntervalSince1970: TimeInterval(self.listaReporte[indexPath.row].getLlegadaAqp())/1000.0)
            let sAqp = NSDate(timeIntervalSince1970: TimeInterval(self.listaReporte[indexPath.row].getSalidaAqp())/1000.0)
            let mAqp = NSDate(timeIntervalSince1970: TimeInterval(self.listaReporte[indexPath.row].getLlegadaMina())/1000.0)
            cell.limaLlegada?.text = formatter.string(from: sLima as Date)
            cell.arequipaLlegada?.text = formatter.string(from: lAqp as Date)
            cell.arequipaPartida?.text = formatter.string(from: sAqp as Date)
            cell.minaLlegada?.text = formatter.string(from: mAqp as Date)
            cell.fechaRegistro?.text = formatter.string(from: mAqp as Date)
            var fecha = (self.listaReporte[indexPath.row].getSalidaLima() > self.listaReporte[indexPath.row].getLlegadaAqp()) ? self.listaReporte[indexPath.row].getSalidaLima() : self.listaReporte[indexPath.row].getLlegadaAqp()
            fecha = (self.listaReporte[indexPath.row].getSalidaAqp() > fecha) ? self.listaReporte[indexPath.row].getSalidaAqp() : fecha
            fecha = (self.listaReporte[indexPath.row].getLlegadaMina() > fecha ? self.listaReporte[indexPath.row].getLlegadaMina() : fecha)
            let _fechaDouble = Double(fecha)
            let _fecha = NSDate(timeIntervalSince1970: TimeInterval( _fechaDouble/1000.0))
            cell.fechaRegistro?.text = formatter.string(from: _fecha as Date)
        }
        cell.numeroItem?.text = "Numero de Item: " + self.listaReporte[indexPath.row].getNumeroItem()
        let date = NSDate(timeIntervalSince1970: TimeInterval(self.listaReporte[indexPath.row].getFechaRecepcion())/1000.0)
        
        
        cell.nombrePreveedor?.text = self.listaReporte[indexPath.row].getNombreProveedor()
        cell.fechaRecepcion?.text = formatter.string(from: date as Date)
        cell.solicitado?.text = self.listaReporte[indexPath.row].getCantidad()
        cell.recibido?.text = self.listaReporte[indexPath.row].getCantidadPO()
        cell.descripcion?.text = self.listaReporte[indexPath.row].getDescripcion()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 492
    }
    
    @objc func cerrarSession(){
        UserDefaults.standard.set(VACIO, forKey: "user")
        UserDefaults.standard.set(VACIO, forKey: "pass")
        let loginView = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        present(loginView, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        numeroGuia.resignFirstResponder()
        return true
    }
}
