//
//  TabBarViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/7/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    var objetoCarga = Array<Item>()
    var objetoOrden = OrdenDTO()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem     = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cerrar Sesion", style: .plain, target: nil, action: nil)
    }
}
