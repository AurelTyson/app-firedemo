//
//  EditerItemViewController.swift
//  FireDemo
//
//  Created by Aurélien Tison on 30/10/2016.
//  Copyright © 2016 aureltyson. All rights reserved.
//

import UIKit
import ActionKit

open class EditerItemViewController: UIViewController {
    
    // MARK: - Constantes
    
    // MARK: - Attributs graphiques
    
    @IBOutlet fileprivate weak var labelNom: UILabel!
    @IBOutlet fileprivate weak var textFieldNom: UITextField!
    @IBOutlet fileprivate weak var btnValider: UIButton!
    
    // MARK: - Attributs
    
    fileprivate var currentItem: Item!
    
    // MARK: - View
    
    public init(item: Item) {
        super.init(nibName: "EditerItemViewController", bundle: nil)
        
        // Stockage
        self.currentItem = item
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // On affiche pas le petit clavier pour masquer le grand
        self.view.dontUseDefaultRetractViewAsDodgeViewForMLInputDodger = false
        
        // Set du nom dans le textField
        self.textFieldNom.text = self.currentItem.nom
        
        // Le bouton de validation
        self.btnValider.addControlEvent(.touchUpInside) {
            
            // Set du nom
            self.currentItem.nom = self.textFieldNom.text!
            
            // Sauvegarde
            self.currentItem.save()
            
            // Retour en arrière
            _ = self.navigationController?.popViewController(animated: true)
            
        }
        
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // L'écart à mettre entre le clavier et le TextField
        self.view.shiftHeightAsDodgeViewForMLInputDodger = 150.0
        
        // Activation de MLInputDodger
        self.view.registerAsDodgeViewForMLInputDodger(withOriginalY: self.view.frame.origin.y)
        
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    // MARK: - Mémoire
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Méthodes
    
}
