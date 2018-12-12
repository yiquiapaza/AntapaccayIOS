//
//  ListaViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/19/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit

class ListaViewController: UIViewController, UITableViewDelegate,   UITableViewDataSource {
    

    var objetoCarga = Array<Item>()
    var objetoOrden = OrdenDTO()
    
    @IBOutlet weak var tableLista: UITableView!
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()

        tableLista.delegate = self
        tableLista.dataSource = self
        tableLista.register(UINib(nibName: "BultoComponentTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        self.view.addSubview(tableLista)
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SeguimientoCargaViewController
        {
            let vs = segue.destination as? SeguimientoCargaViewController
            vs!._listaItem = self.objetoCarga
        }
        
        if segue.destination is TabBarViewController
        {
            let vs = segue.destination as? TabBarViewController
            vs!.objetoCarga = self.objetoCarga
            vs!.objetoOrden = self.objetoOrden
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objetoCarga.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableLista.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BultoComponentTableViewCell
        cell.numeroOrden.text! = objetoCarga[indexPath.row].getNumeroItem()
        cell.descripcionOrden.text! = objetoCarga[indexPath.row].getDescripcion()
        cell.quitarButton.addTarget(self, action: #selector(quitar(_: )), for: .touchDown)
        cell.quitarButton.tag = indexPath.row
        return cell
    }
    
    @objc func quitar(_ sender: UIButton){
        objetoCarga.remove(at: sender.tag)
        tableLista.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableLista.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
}

