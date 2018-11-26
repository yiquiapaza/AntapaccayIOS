//
//  UnidadTransporteViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/26/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit
import Alamofire

class UnidadTransporteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(ALMACENES_DESTINO)
        .responseJSON(){
            response in switch response.result{
            case .success(let data):
                    print(data)
            case .failure(let error):
                    print(error)
            }
        }
        Alamofire.request(TIPO_SEMIREMOLQUE)
        .responseJSON(){
            response in switch response.result{
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
        let parametres : Parameters = [
            "tipoVehiculo" : "R",
            "tipoRegistro" : "T",
            "tipoCarroceria" : "-"
        ]
        Alamofire.request(PLACAS_SEMIREMOLQUE, method: .post, parameters: parametres, encoding: JSONEncoding.default)
            .responseJSON(){
                response in switch response.result{
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error)
                }
        }
    }
}
