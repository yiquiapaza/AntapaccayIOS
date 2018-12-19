//
//  SalidaCargaViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/28/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSpinner
import PMAlertController

class SalidaCargaViewController: UIViewController {

    var lista = Array<Registro>()
    var llegada = Array<Llegada>()
    
    @IBOutlet weak var numeroGuia: UITextField!
    
    @IBOutlet weak var almacenDestino: UILabel!
    @IBOutlet weak var puntoPartida: UILabel!
    @IBOutlet weak var numero_guia: UILabel!
    @IBOutlet weak var numero_transporte: UILabel!
    @IBOutlet weak var llegadaButton: UIButton!
    
    override func viewDidLoad() {
        llegadaButton.isEnabled = true
        super.viewDidLoad()
    }
    
    @IBAction func buquedarGuia(_ sender: UIButton) {
        
        let parametres : Parameters = [
            "numeroGuia" : numeroGuia.text!,
            "estadoTransporte" :"2"
        ]
        self.delay(secons: 3.0, completatio: {
            SwiftSpinner.show("Verificando Datos")
            Alamofire.request(BUSQUEDA_GUIA_ENTRADA, method: .post, parameters: parametres, encoding: JSONEncoding.default)
                .responseJSON(){
                    response in switch response.result{
                    case .success(let data):
                        let nuevo = data as! [Dictionary <String, AnyObject>]
                        self.numero_guia.text = self.numeroGuia.text
                        for item in nuevo{
                            let a = Registro()
                            a.setId(id: item["Id"] as! String)
                            a.setIdPuntoPartida(idPuntoPartida: item["idPuntoPartida"] as! String)
                            a.setCodigoDestino(codigoDestino: item["codigoDestino"] as! String)
                            a.setNumeroTransporte(numeroTransporte: item["numeroTransporte"] as! Int)
                            a.setCodigo(codigo: item["codigo"] as! String)
                            a.setNombrePuntoPartida(nombrePuntoPartida: item["nombrePuntoPartida"] as! String)
                            a.setNombreDestino(nombreDestino: item["nombreDestino"] as! String)
                            a.setCodigoVehiculo(codigoVehiculo: item["codigoVehiculo"] as! String)
                            a.setCodigoConfiguracionTracto(codigoConfiguracionTracto: item["codigoConfiguracionTracto"] as! String)
                            a.setConfiguracionTracto(configuracionTracto: item["configuracionTracto"] as! String)
                            a.setPlacaRemolque(placaRemolque: item["placaRemolque"] as! String)
                            a.setCodigoTipoRemolque(codigoTipoRemolque: item["codigoTipoRemolque"] as! String)
                            a.setTipoRemolque(tipoRemolque: item["tipoRemolque"] as! String)
                            a.setCodigoConductor(codigoConductor: item["codigoConductor"] as! String)
                            a.setNombreConductor(nombreConductor: item["nombreConductor"] as! String)
                            a.setServicioExpreso(servicioExpreso: item["servicioExpreso"] as! Bool)
                            a.setPrecio(precio: item["precio"] as! Float)
                            a.setEstadoTransporte(estadoTransporte: item["estadoTransporte"] as! String)
                            a.setCodigoConfiguracionRemolque(codigoConfiguracionRemolque: item["codigoConfiguracionRemolque"] as! String)
                            a.setConfiguracionRemolque(configuracionRemolque: item["configuracionRemolque"] as! String)
                            a.setFechaInicio(fechaInicio: item["fechaInicio"] as! Int)
                            a.setGuiaAntapaccay(guiaAntapaccay: item["guiaAntapaccay"] as! Bool)
                            a.setCodigoTransportista(codigoTransportista: item["codigoTransportista"] as! String)
                            a.setTransportista(transportista: item["transportista"] as! String)
                            a.setRowVersion(RowVersion: item["RowVersion"] as! String)
                            self.lista.append(a)
                        }
                        SwiftSpinner.hide()
                        print(data)
                        if self.lista.isEmpty {
                            print("no hay nada ????")
                            let error = PMAlertController(title: "Error", description: "verifique si la guia es valida", image: UIImage(named: "error"), style: .alert)
                            error.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
                            self.present(error, animated: true, completion: nil)
                            SwiftSpinner.hide()
                        }
                        else {
                            self.almacenDestino.text = self.lista[0].getNombreDestino()
                            self.puntoPartida.text = self.lista[0].getCodigoDestino()
                            self.numero_transporte.text = String(self.lista[0].getNumeroTransporte())
                            let nuevoParameter: Parameters = [
                                "idTransporte": self.lista[0].getId(),
                                "codigoPuntoControl": "-"
                            ]
                            Alamofire.request(ESTADO_RECORRIDO, method: .post, parameters: nuevoParameter, encoding: JSONEncoding.default)
                                .responseJSON(){
                                    response in switch response.result{
                                    case .success(let data):
                                        let nuevo = data as! [Dictionary <String, AnyObject>]
                                        for item in nuevo {
                                            let nuevo = Llegada()
                                            nuevo.setId(id: item["Id"] as! String)
                                            nuevo.setIdTransporte(idTransporte: item["idTransporte"] as! String)
                                            nuevo.setFechaOperacion(fechaOperacion: item["fecha"] as! Int)
                                            nuevo.setTipoOperacion(tipoOperacion: item["tipoOperacion"] as! String)
                                            nuevo.setUsuarioOperacion(usuarioOperacion: item["usuarioOperacion"] as! String)
                                            nuevo.setUltimaOperacion(ultimaOperacion: item["ultimaOperacion"] as! Bool)
                                            nuevo.setCodigoPuntoControl(codigoPuntoControl: item["codigoPuntoControl"] as! String)
                                            nuevo.setNombrePuntoControl(nombrePuntoControl: item["nombrePuntoControl"] as! String)
                                            nuevo.setRowVersion(RowVersion: item["RowVersion"] as! String)
                                            self.llegada.append(nuevo)
                                        }
                                        if self.llegada.isEmpty {
                                            print("no hay nada ????")
                                            let error = PMAlertController(title: "El transporte todavia no ha salido de almacen", description: "verifique si la guia es valida caso contrario", image: UIImage(named: "precaucion"), style: .alert)
                                            error.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
                                            self.present(error, animated: true, completion: nil)
                                            SwiftSpinner.hide()
                                        }
                                        else {
                                            if self.llegada[0].getTipoOperacion() == "PARTIDA"{
                                                let error = PMAlertController(title: "Registro de Salida", description: "no se registro salida de " + self.llegada[0].getNombrePuntoControl(), image: UIImage(named: "precaucion"), style: .alert)
                                                error.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
                                                self.present(error, animated: true, completion: nil)
                                                SwiftSpinner.hide()
                                            }
                                            if (self.llegada[0].getCodigoPuntoControl() == "008" || self.llegada[0].getCodigoPuntoControl() == "ALMC"){
                                                let error = PMAlertController(title: "Registro de Salida", description: "ya se registro la llegada " + self.llegada[0].getNombrePuntoControl(), image: UIImage(named: "precaucion"), style: .alert)
                                                error.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
                                                self.present(error, animated: true, completion: nil)
                                                SwiftSpinner.hide()
                                            }
                                            else {
                                                let exito = PMAlertController(title: "Exito", description: "Se obtuvieron los datos correctamente", image: UIImage(named: "exito"), style: .alert )
                                                exito.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
                                                self.llegadaButton.isEnabled = false
                                                self.present(exito, animated: true, completion: nil)
                                                SwiftSpinner.hide()
                                            }
                                        }
                                        print(data)
                                    case .failure(let error):
                                        let errorMessaje = PMAlertController(title: "Error", description: "Verifique si tiene coneccion a Internet", image: UIImage(named: "Aceptar"), style: .alert)
                                        errorMessaje.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
                                        self.present(errorMessaje, animated: true, completion: nil)
                                        SwiftSpinner.hide()
                                        print(error)
                                    }
                            }
                        }
                        
                    case .failure(let error):
                        print(error)
                        let errorMessaje = PMAlertController(title: "Error", description: "Verifique si tiene coneccion a Internet", image: UIImage(named: "Aceptar"), style: .alert)
                        errorMessaje.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
                        self.present(errorMessaje, animated: true, completion: nil)
                        SwiftSpinner.hide()
                    }
            }
            
        })
        
    }
    
    @IBAction func registroLlegada(_ sender: Any) {
        print("estoy aca")
        let transporteRecorrido : Parameters = [
            "Id": CONST_ID,
            "RowVersion": CONST_ROW_VERSION,
            "idTransporte": self.lista[0].getId(),
            "fecha": obtenerFecha(),
            "tipoOperacion": "LLEGADA",
            "usuarioOperacion": "",
            "codigoPuntoControl": lista[0].getIdPuntoPartida(),
            "nombrePuntoControl": lista[0].getNombrePuntoPartida()            
        ]
        
        let transporte : Parameters = [
            "Id": lista[0].getId(),
            "idPuntoPartida" : lista[0].getIdPuntoPartida(),
            "codigoDestino" : lista[0].getCodigoDestino(),
            "numeroTransporte": lista[0].getNumeroTransporte(),
            "codigo": lista[0].getCodigo(),
            "nombrePuntoPartida" : lista[0].getNombrePuntoPartida(),
            "nombreDestino" : lista[0].getNombreDestino(),
            "codigoVehiculo": lista[0].getCodigoVehiculo(),
            "codigoConfiguracionTracto": lista[0].getCodigoConfiguracionTracto(),
            "configuracionTracto": lista[0].getConfiguracionTracto(),
            "placaRemolque": lista[0].getPlacaRemolque(),
            "codigoTipoRemolque": lista[0].getCodigoTipoRemolque(),
            "tipoRemolque" : lista[0].getTipoRemolque(),
            "codigoConductor" : lista[0].getCodigoConductor(),
            "nombreConductor" : lista[0].getNombreConductor(),
            "servicioExpreso" : lista[0].getServicioExpreso(),
            "precio" : lista[0].getPrecio(),
            "estadoTransporte" : 2,// este cambiar
            "codigoConfiguracionRemolque" : lista[0].getCodigoConfiguracionRemolque(),
            "configuracionRemolque": lista[0].getConfiguracionRemolque(),
            "fechaInicio" : obtenerFecha(),
            "totalPaletas" : lista[0].getTotalPaletas(),
            "guiaTransportista": lista[0].getGuiaTransportista(),
            "guiaAntapaccay": lista[0].getGuiaAntapaccay(),
            "codigoTransportista" : lista[0].getCodigoTransportista(),
            "transportista" : lista[0].getTransportista(),
            "RowVersion" : lista[0].getRowVersion()
        ]
        
        let parameters : Parameters = [
            "transporteRecorrido" : transporteRecorrido,
            "transporte" : transporte
        ]
        
        Alamofire.request(REGISTRO_LLEGADA, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON(){
                response in switch response.result{
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error)
                }
        }
        
    }
    
    
    func delay(secons:Double, completatio: @escaping () -> ()) -> Void {
        let popTIme = DispatchTime.now() + Double(Int64(Double(NSEC_PER_SEC) * secons))/Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: popTIme){
            completatio()
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
    
}
