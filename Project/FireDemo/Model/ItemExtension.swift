//
//  ItemExtension.swift
//  FireDemo
//
//  Created by Aurélien Tison on 30/10/2016.
//  Copyright © 2016 aureltyson. All rights reserved.
//

import UIKit

extension Item {
    
    // MARK: - Méthodes (utilitaires)
    
    internal func getDataAsString(key: String) -> String {
        
        guard let lValue = dataObject[key] as? String else {
            return ""
        }
        
        return lValue
        
    }
    
    internal func getDataAsInt(key: String) -> Int {
        
        guard let lValue = dataObject[key] as? Int else {
            return 0
        }
        
        return lValue
        
    }
    
    internal func getDataAsDouble(key: String) -> Double {
        
        guard let lValue = dataObject[key] as? Double else {
            return 0
        }
        
        return lValue
        
    }
    
    internal func getDataAsDate(key: String) -> Date {
        
        guard let lValue = dataObject[key] as? Date else {
            return Date()
        }
        
        return lValue
        
    }
    
    // MARK: - Surcharges
    
    static func == (left: Item, right: Item) -> Bool {
        return left.ref == right.ref
    }
    
    override open func isEqual(_ object: Any?) -> Bool {
        guard let lObject = object as? Item else {
            return false
        }
        return self.ref == lObject.ref
    }

}
