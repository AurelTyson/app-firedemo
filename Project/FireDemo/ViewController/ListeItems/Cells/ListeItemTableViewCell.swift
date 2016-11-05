//
//  ListeItemTableViewCell.swift
//  FireDemo
//
//  Created by Aurélien Tison on 30/10/2016.
//  Copyright © 2016 aureltyson. All rights reserved.
//

import UIKit
import ActionKit

open class ListeItemTableViewCell: UITableViewCell {
    
    // MARK: - Attributs graphiques
    
    @IBOutlet fileprivate weak var labelNom: UILabel!
    @IBOutlet fileprivate weak var btnEtat: UIButton!
    @IBOutlet fileprivate weak var btnDelete: UIButton!
    
    // MARK: - Attributs
    
    public var actionBtnEtat: (() -> Void)?
    public var actionBtnDelete: (() -> Void)?
    
    // MARK: - View
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Le bouton d'etat
        self.btnEtat.titleLabel?.font = .materialIcon(size: 20)
        self.btnEtat.setTitle("panorama_fish_eye", for: .normal)
        self.btnEtat.setTitle("done", for: .selected)
        self.btnEtat.removeControlEvent(.touchUpInside)
        self.btnEtat.addControlEvent(.touchUpInside) {
            self.actionBtnEtat?()
        }
        
        // Le bouton de suppression
        self.btnDelete.titleLabel?.font = .materialIcon(size: 20)
        self.btnDelete.setTitle("delete", for: .normal)
        self.btnDelete.removeControlEvent(.touchUpInside)
        self.btnDelete.addControlEvent(.touchUpInside) {
            self.actionBtnDelete?()
        }
        
    }

    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Méthodes
    
    open func set(item: Item) {
        
        // Le nom
        self.labelNom.text = item.nom
        
        // L'état
        self.btnEtat.isSelected = item.etat == .checked
        
    }
    
}
