//
//  User.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 10/30/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import Foundation


class User {

    private var UserId : String
    private var FirstName : String
    private var LastName : String
    private var Email : String
    private var Foto : String
    private var CodigoTransportista : String
    private var Roles : Array<Dictionary<String,Any>>
    private var UserName : String
    private var ProviderUserKey : String
    private var PasswordQuestion : String
    private var Comment : String
    private var IsAppoved : Bool
    private var IsLockedOut : Bool
    private var LastLockoutDate : String
    private var CreationDate : String
    private var LastLoginDate : String
    private var LastActivityDate : String
    private var LastPasswordChangedDate : String
    private var IsOnline : Bool
    private var ProviderName : String
    
    init() {
        self.UserId = VACIO
        self.FirstName = VACIO
        self.LastName = VACIO
        self.Email = VACIO
        self.Foto = VACIO
        self.CodigoTransportista = VACIO
        self.Roles = Array<Dictionary<String,Any>>()
        self.UserName = VACIO
        self.ProviderUserKey = VACIO
        self.PasswordQuestion = VACIO
        self.Comment = VACIO
        self.IsAppoved = false
        self.IsLockedOut = false
        self.LastLockoutDate = VACIO
        self.CreationDate = VACIO
        self.LastLoginDate = VACIO
        self.LastActivityDate = VACIO
        self.LastPasswordChangedDate = VACIO
        self.IsOnline = false
        self.ProviderName = VACIO
    }
    
    func setUserId(UserId: String) -> Void {
        self.UserId = UserId
    }
    func getUserid() -> String {
        return self.UserId
    }
    
    func setFirstName(FirstName: String) -> Void {
        self.FirstName = FirstName
    }
    func getFirstName() -> String {
        return self.FirstName
    }
    
    func setLastName(LastName : String) -> Void {
        self.LastName = LastName
    }
    func getLastName() -> String {
        return self.LastName
    }
    
    func setEmail(Email: String) -> Void {
        self.Email = Email
    }
    func getEmail() -> String {
        return self.Email
    }
    
    func setFoto(Foto :String) -> Void {
        self.Foto = Foto
    }
    func getFoto() -> String {
        return self.Foto
    }
    
    func setCodigoTransportista(CodigoTransportista: String) -> Void {
        self.CodigoTransportista = CodigoTransportista
    }
    func getCodigoTransportista() -> String {
        return self.CodigoTransportista
    }
    
    func getRoles(Roles : Array<Dictionary<String,Any>> ) -> Void {
        self.Roles = Roles
    }
    func getRoles() -> Array<Dictionary<String,Any>> {
        return self.Roles
    }
    
    func setUserName(UserName: String) -> Void {
        self.UserName = UserName
    }
    func getUserName() -> String {
        return self.UserName
    }
    
    func setProviderUserKey(ProviderUserKey : String) -> Void {
        self.ProviderUserKey = ProviderUserKey
    }
    func getProviderUserKey() -> String {
        return self.ProviderUserKey
    }
    
    func setPasswordQuestion(PasswordQuestion: String) -> Void {
        self.PasswordQuestion = PasswordQuestion
    }
    func getPasswordQuestion() -> String {
        return self.PasswordQuestion
    }
    
    func setComment(Comment:String) -> Void {
        self.Comment = Comment
    }
    func getComment() -> String {
        return self.Comment
    }
    
    func setIsAppoved(IsAppoved:Bool) -> Void {
        self.IsAppoved = IsAppoved
    }
    func getIsAppoved() -> Bool {
        return self.IsAppoved
    }
    
    func setIsLockedOut(IsLockedOut: Bool) -> Void {
        self.IsLockedOut = IsLockedOut
    }
    func getIsLockedOut() -> Bool {
        return self.IsLockedOut
    }
    
    func setLastLockoutDate(LastLockoutDate:String) -> Void {
        self.LastLockoutDate = LastLockoutDate
    }
    func getLastLockoutDate() -> String {
        return self.LastLockoutDate
    }
    
    func setCreationDate(CreationDate:String) -> Void {
        self.CreationDate = CreationDate
    }
    func getCreationDate() -> String {
        return self.CreationDate
    }
    
    func setLastLoginDate(LastLoginDate : String) -> Void {
        self.LastLoginDate = LastLoginDate
    }
    func getLastLoginDate() -> String {
        return self.LastLoginDate
    }
    
    func setLastActivityDate(LastActivityDate : String) -> Void {
        self.LastActivityDate = LastActivityDate
    }
    func getLastActivityDate() -> String {
        return self.LastActivityDate
    }
    
    func setLastPasswordChangedDate(LastPasswordChangedDate: String) -> Void {
        self.LastPasswordChangedDate = LastPasswordChangedDate
    }
    func getLastPasswordChangedDate() -> String {
        return self.LastPasswordChangedDate
    }
    
    func setIsOnline(IsOnline: Bool) -> Void {
        self.IsOnline = IsOnline
    }
    func getIsOnline() -> Bool {
        return self.IsOnline
    }
    
    func setProviderName(ProviderName:String) -> Void {
        self.ProviderName = ProviderName
    }
    func getProviderName() -> String {
        return self.ProviderName
    }
}
