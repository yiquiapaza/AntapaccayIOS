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
        self.navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
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
