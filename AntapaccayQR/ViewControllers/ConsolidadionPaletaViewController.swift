//
//  ConsolidadionPaletaViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/26/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSpinner
import PMAlertController

class ConsolidadionPaletaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var listaPaleta = Array<Paleta>()
    
    @IBOutlet weak var tablaBulto: UITableView!
    @IBOutlet weak var getBulto: UITextField!
    let cellReuseIdentifier = "cell"
    var index = -1
    
    override func viewDidLoad() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cerrar Session", style: .plain, target: self, action: #selector(cerrarSession))
        
        super.viewDidLoad()
        
        self.getBulto.delegate = self
        tablaBulto.delegate = self
        tablaBulto.dataSource = self
        tablaBulto.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        self.view.addSubview(tablaBulto)
    }
    
    @IBAction func findBulto(_ sender: UIButton) {
        
        var parametres = Parameters()
        if QR_CONST_PALETA == VACIO {
            parametres = [
                "logical": "AND",
                "PropertyName": "codigo",
                "Value": getBulto.text!,
                "Operator": "Equals"
            ]
        }
        else {
            getBulto.text! = QR_CONST_PALETA
            parametres = [
                "logical" : "AND",
                "PropertyName": "Id",
                "Value": getBulto.text!,
                "Operator": "Equals"
            ]
        }
        
        if getBulto.text! == ""{
            let alertBulto = PMAlertController(title: "Ingrese un codigo de un Bulto", description: "Es un campo Obligatorio", image: UIImage(named: "precaucion"), style: .alert)
            alertBulto.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
            self.present(alertBulto, animated: true, completion: nil)
        }
        else {
            self.delay(secons: 3.0, completatio: {
                SwiftSpinner.show("Verificando API")
                Alamofire.request(BUSQUEDA_BULTO_BY_ID, method: .post, parameters: parametres, encoding: JSONEncoding.default)
                    .responseJSON() {
                        response in switch response.result{
                        case .success:
                            let outList = response.result.value as! [Dictionary<String, Any>]
                            if outList.isEmpty {
                                let alertOrden = PMAlertController(title: "Error", description: "Numero de Bulto erroneo", image: UIImage(named: "error"), style: .alert)
                                alertOrden.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
                                self.present(alertOrden, animated: true, completion: nil)
                                SwiftSpinner.hide()
                            }
                            else {
                                for item in outList {
                                    let nuevo = Paleta()
                                    nuevo.setId(Id: item["Id"] as? String ?? "")
                                    nuevo.setIdPaleta(IdPaleta: item["idPaleta"] as? String ?? "")
                                    nuevo.setIdAlmacenRecepcion(IdAlmacenRecepcion: item["idAlmacenRecepcion"] as? String ?? "")
                                    nuevo.setNumeroBulto(numeroBulto: item["numeroBulto"] as? Int ?? 0)
                                    nuevo.setCodigo(Codigo: item["codigo"] as? String ?? "")
                                    nuevo.setNombreProveedor(nombreProveedor: item["nombreProveedor"] as? String ?? "")
                                    nuevo.setNombreAlmacen(nombreAlmacen: item["nombreAlmacen"] as? String ?? "")
                                    nuevo.setTipoOrden(tipoOrden: item["tipoOrden"] as? String ?? "")
                                    nuevo.setValorOrden(valorOrden: item["valorOrden"] as? String ?? "")
                                    nuevo.setEstadoBulto(EstadoBulto: item["estadoBulto"] as? String ?? "")
                                    nuevo.setPeso(peso: item["peso"] as! Double)
                                    nuevo.setAlto(alto: item["alto"] as! Double)
                                    nuevo.setAncho(ancho: item["ancho"] as! Double)
                                    nuevo.setLargo(largo: item["largo"] as! Double)
                                    nuevo.setFragil(fragil: item["fragil"] as? Bool ?? false)
                                    nuevo.setSobredimensionado(sobredimensionado: item["sobredimensionado"] as? Bool ?? false)
                                    nuevo.setCargaPeligrosa(cargaPeligrosa: item["cargaPeligrosa"] as? Bool ?? false)
                                    nuevo.setImportacion(importancia: item["importacion"] as? Bool ?? false)
                                    nuevo.setNacional(nacional: item["nacional"] as? Bool ?? false)
                                    nuevo.setFechaRecepcion(fecha: self.obtenerFecha())
                                    nuevo.setTransportista(transportista: item["transportista"] as? String ?? "")
                                    nuevo.setUbicacion(ubicacion: item["ubicacion"] as? String ?? "")
                                    nuevo.setGeneral(general: item["general"] as? Bool ?? false)
                                    nuevo.setComponente(componente: item["componente"] as? Bool ?? false)
                                    nuevo.setUnidadCompleta(unidad: item["unidadCompleta"] as? Bool ?? false)
                                    nuevo.setRowVersion(rowVersion: item["RowVersion"] as? String ?? "")
                                    self.listaPaleta.append(nuevo)
                                    SwiftSpinner.hide()
                                }
                            }
                            self.tablaBulto.reloadData()
                            self.getBulto.text = ""
                        case .failure(let error):
                            print(error)
                            let alertOrden = PMAlertController(title: "Error", description: "revise su conexion de Internet", image: UIImage(named: "error"), style: .alert)
                            alertOrden.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
                            self.present(alertOrden, animated: true, completion: nil)
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
        return self.listaPaleta.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tablaBulto.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.listaPaleta[indexPath.row].getCodigo()
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 300))
        button.addTarget(self, action: #selector(quitar(_:)), for: .touchDown)
        button.setTitle("", for : .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(UIImage(named:"icons8-delete_filled"), for: .normal)
        cell.accessoryView = button
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
    }
    
    @objc func quitar(_ sneder: UIButton){
        if index == -1 {
            //let error = MessageView.viewFromNib(layout: .tabView)
            //error.configureTheme(.error)
            //error.configureContent(title:"Error",body:"Es necesario Seleccionar una Celda" )
            //error.button?.isHidden = true
            //var configError = SwiftMessages.defaultConfig
            //configError.presentationStyle = .center
            //configError.duration = .seconds(seconds: 2)
            //SwiftMessages.show(config: configError , view:error)
        }
        else{
            print("Elimine la filas")
            self.listaPaleta.remove(at: index)
            index = -1
            print(index)
            tablaBulto.reloadData()
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is TabBarBultoViewController{
            let vs = segue.destination as? TabBarBultoViewController
            vs!.listaPaleta = self.listaPaleta
        }
    }
    func obtenerFecha() -> Int {
        var fechaCadena = String()
        let anio = Calendar.current.component(.year, from: Date())
        let mes = Calendar.current.component(.month, from: Date())
        let dia = Calendar.current.component(.day, from: Date())
        if dia < 10{
            fechaCadena = String(anio) + String(mes) + "0" + String(dia)
        }
        else {
            fechaCadena = String(anio) + String(mes) + String(dia)
        }
        return Int(fechaCadena)!
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.getBulto.resignFirstResponder()
        return true
    }
    
    @objc func cerrarSession(){
        UserDefaults.standard.set(VACIO, forKey: "user")
        UserDefaults.standard.set(VACIO, forKey: "pass")
        let loginView = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        present(loginView, animated: true, completion: nil)
    }
}
