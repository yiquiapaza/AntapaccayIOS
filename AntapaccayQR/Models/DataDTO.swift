//
//  DataDTO.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/27/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import Foundation

class DataDTO {
    private var id : Int
    private var data1: String
    private var data2: String
    private var data3: String
    
    init() {
        self.id = 0
        self.data1 = VACIO
        self.data2 = VACIO
        self.data3 = VACIO
    }
    
    func setId(id: Int) -> Void {
        self.id = id
    }
    func getID() -> Int {
        return self.id
    }
    
    func setData1(data1 : String) -> Void {
        self.data1 = data1
    }
    func getData1() -> String {
        return self.data1
    }
    
    func setData2(data2 : String) -> Void {
        self.data2 = data2
    }
    func getData2() -> String {
        return self.data2
    }
    
    func setData3(data3 : String) -> Void {
        self.data3 = data3
    }
    func getData3() -> String {
        return self.data3
    }
}
