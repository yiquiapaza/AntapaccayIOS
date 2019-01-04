//
//  User.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 10/30/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import Foundation


class User {
    private var Id : String
    private var userid : String
    private var password : String
    private var email : String
    private var token : String
    private var codigoTransportista : String
    private var userAD : String
    private var RowVersion : String
    
    init() {
        self.Id = VACIO
        self.userid = VACIO
        self.password = VACIO
        self.email = VACIO
        self.token = VACIO
        self.codigoTransportista = VACIO
        self.userAD = VACIO
        self.RowVersion = VACIO
    }
    
    func setUserid(userid: String) -> Void {
        self.userid = userid
    }
    func getUserid() -> String {
        return self.userid
    }
    
    func setPassword(password: String) -> Void{
        self.password = password
    }
    func getPassword() -> String {
        return self.password
    }
}
