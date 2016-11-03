//
//  ListeItemTableViewCell.swift
//  FireDemo
//
//  Created by Aurélien Tison on 30/10/2016.
//  Copyright © 2016 aureltyson. All rights reserved.
//

import UIKit

open class ListeItemTableViewCell: UITableViewCell {
    
    // MARK: - Attributs

    @IBOutlet fileprivate weak var labelNom: UILabel!
    @IBOutlet fileprivate weak var btnEtat: UIButton!
    
    // MARK: - View
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
