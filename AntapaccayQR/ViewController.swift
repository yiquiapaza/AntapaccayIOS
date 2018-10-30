//
//  ViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 29/10/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: LOGIN_SEGEN, sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

