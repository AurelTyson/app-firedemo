//
//  Item.swift
//  FireDemo
//
//  Created by Aurélien Tison on 30/10/2016.
//  Copyright © 2016 aureltyson. All rights reserved.
//

import UIKit
import Firebase

open class Item: NSObject {
    
    // MARK: - Enums
    
    public enum Etat: String {
        case unchecked = "unchecked"
        case checked = "checked"
    }
    
    // MARK: - Attributs
    
    public var dataSnapshot: FIRDataSnapshot?
    public var dataObject: [String : Any]!
    
    public var ref: String? {
        get {
            return self.dataSnapshot?.key
        }
    }
    
    public var nom: String {
        get {
            return self.getDataAsString(key: "nom")
        }
        set(value) {
            self.dataObject["nom"] = value
        }
    }
    
    public var etat: Etat {
        get {
            guard let lEtat = self.dataObject["etat"] as? String else {
                return Etat.unchecked
            }
            return Etat(rawValue: lEtat)!
        }
        set(value) {
            self.dataObject["etat"] = value.rawValue
        }
    }
    
    public var ordre: Int {
        get {
            return self.getDataAsInt(key: "ordre")
        }
        set(value) {
            self.dataObject["ordre"] = value
        }
    }
    
    // MARK: - Initialisation
    
    override public init() {
        super.init()
        
        // Initialisation
        self.dataSnapshot = nil
        self.dataObject = [String : Any]()
        
    }
    
    public init(snapshot: FIRDataSnapshot) {
        super.init()
        
        // Stockage
        self.dataSnapshot = snapshot
        self.dataObject = snapshot.value as! [String : Any]
        
    }
    
    // MARK: - Méthodes (CRUD)
    
    public func save() {
        
        // La reference
        let lDatabaseRef = FIRDatabase.database().reference()
        
        // Le noeuf de sauvegarde
        var lChildNode: FIRDatabaseReference!
        
        // Si on a une clé
        if let lRef = self.ref {
            
            // Mise à jour
            lChildNode = lDatabaseRef.child("items").child(lRef)
            
        }
        else {
            
            // Création
            lChildNode = lDatabaseRef.child("items").childByAutoId()
            
        }
        
        // Sauvegarde
        lChildNode.setValue(self.dataObject)
        
    }
    
    public func delete() {
        
        // Si on a une clé
        guard let lRef = self.ref else {
            return
        }
        
        // La reference
        let lDatabaseRef = FIRDatabase.database().reference()
        
        // Le noeuf de sauvegarde
        let lChildNode = lDatabaseRef.child("items").child(lRef)
        
        // Suppression
        lChildNode.removeValue()
        
    }

}
