//
//  CameraBultoViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/26/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit
import AVFoundation

class CameraBultoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    var imageView = UIImageView()
    @IBOutlet weak var collection: UICollectionView!
    
    
    override func viewDidLoad() {
        self.collection.reloadData()
        self.collection.delegate = self
        self.collection.dataSource = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cerrar Session", style: .plain, target: self, action: #selector(cerrarSession))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        super.viewDidLoad()
    }
    
    @IBAction func openCameraButton(sender: AnyObject) {
    }
    
    @objc func cerrarSession(){
        UserDefaults.standard.set(VACIO, forKey: "user")
        UserDefaults.standard.set(VACIO, forKey: "pass")
        let loginView = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        present(loginView, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.collection.reloadData()
        return LISTA_PALETA.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let imagen = LISTA_PALETA[indexPath.row]
        imageView.image = UIImage(data: imagen)
        cell.contentView.addSubview(imageView)
        return cell
    }
    
}
