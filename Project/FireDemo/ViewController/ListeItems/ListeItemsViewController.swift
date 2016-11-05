//
//  ListeItemsViewController.swift
//  FireDemo
//
//  Created by Aurélien Tison on 30/10/2016.
//  Copyright © 2016 aureltyson. All rights reserved.
//

import UIKit
import ActionKit
import FBSDKLoginKit
import Firebase
import MLInputDodger

open class ListeItemsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Constantes
    
    fileprivate let kCellIdentifier = "cellItem"
    
    // MARK: - Attributs graphiques
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    // MARK: - Attributs
    
    fileprivate var currentUser: FIRUser!
    
    fileprivate var fireRef: FIRDatabaseReference?
    fileprivate var listeRefHandler = [UInt]()
    
    fileprivate var listeItems = [Item]()
    
    // MARK: - View
    
    public init(user: FIRUser) {
        super.init(nibName: "ListeItemsViewController", bundle: nil)
        
        // Stockage
        self.currentUser = user
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // On affiche pas le petit clavier pour masquer le grand
        self.view.dontUseDefaultRetractViewAsDodgeViewForMLInputDodger = false
        
        // La tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "ListeItemTableViewCell", bundle: nil), forCellReuseIdentifier: kCellIdentifier)
        
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
        
        // Le bouton d'ajout
        let lBtnAjout = UIButton()
        lBtnAjout.titleLabel?.font = .materialIcon(size: 20)
        lBtnAjout.setTitle("add", for: .normal)
        lBtnAjout.setTitleColor(.black, for: .normal)
        lBtnAjout.addControlEvent(.touchUpInside) {
            
            // L'item à créer
            let lItem = Item()
            
            // Ordre
            lItem.ordre = self.listeItems.count + 1
            
            // La vue d'edition
            let lEditerItemViewController = EditerItemViewController(item: lItem)
            
            // Affichage
            self.navigationController?.pushViewController(lEditerItemViewController, animated: true)
            
        }
        lBtnAjout.sizeToFit()
        
        // Le bouton de déconnexion
        let lBtnDeconnexion = UIButton()
        lBtnDeconnexion.titleLabel?.font = .materialIcon(size: 20)
        lBtnDeconnexion.setTitle("exit_to_app", for: .normal)
        lBtnDeconnexion.setTitleColor(.black, for: .normal)
        lBtnDeconnexion.addControlEvent(.touchUpInside) {
            
            do {
                
                // Déconnexion
                FBSDKLoginManager().logOut()
                try FIRAuth.auth()?.signOut()
                
            }
            catch {
                
                NSLog(">> Erreur de déconnexion")
                
            }
            
            // Fermeture du navigationController
            self.navigationController?.dismiss(animated: true, completion: nil)
            
        }
        lBtnDeconnexion.sizeToFit()
        
        // Transformation en UIBarButtonItem (obligé de faire ça sinon le bouton n'est pas centré)
        let lBarBtnAdd = UIBarButtonItem(customView: lBtnAjout)
        let lBarBtnDeconnexion = UIBarButtonItem(customView: lBtnDeconnexion)
        
        // Ajout à la navigationBar
        self.navigationController?.navigationBar.topItem!.rightBarButtonItems = [lBarBtnAdd]
        self.navigationController?.navigationBar.topItem?.leftBarButtonItems = [lBarBtnDeconnexion]
        
        // Chargement des données
        self.refreshData()
        
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Si on a une reference
        if let lReference = self.fireRef {
            
            // Boucle sur les refHandler
            self.listeRefHandler.forEach({ lReference.removeObserver(withHandle: $0) })
            
        }
        
    }
    
    // MARK: - Mémoire
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Méthodes
    
    private func refreshData() {
        
        // La ref
        self.fireRef = FIRDatabase.database().reference()
        
        // Récupération des listes
        let lRefHandler = self.fireRef!.child("items").observe(.value, with: { (snapshot: FIRDataSnapshot) in
            
            // Initialisation de la liste
            self.listeItems = [Item]()
            
            // Si snapshot
            if snapshot.exists() {
                
                // La map reçue
                let lMap = snapshot.value as! [String : Any]
                
                // Boucle sur les listes
                lMap.forEach({ (key: String, value: Any) in
                    
                    // Nouvelle liste
                    let lListe = Item(snapshot: snapshot.childSnapshot(forPath: key))
                    
                    // Si existante
                    if let lIndex = self.listeItems.index(of: lListe) {
                        
                        // Mise à jour
                        self.listeItems[lIndex] = lListe
                        
                    }
                    else {
                        
                        // Insertion
                        self.listeItems.append(lListe)
                        
                    }
                    
                })
                
                // Tri par ordre
                self.listeItems = self.listeItems.sorted(by: { $0.0.ordre < $0.1.ordre })
                
            }
            
            // Rechargement de la tableView
            self.tableView.reloadData()
            
        })
        
        // Ajout à la liste des refHandler
        self.listeRefHandler.append(lRefHandler)
        
    }
    
    // MARK: - TableView
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
        
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.listeItems.count
        
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Récupération de la cellule
        let lCell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as! ListeItemTableViewCell
        
        // L'item à afficher
        let lItem = self.listeItems[indexPath.row]
        
        // Set des infos
        lCell.set(item: lItem)
        
        // L'action de suppression
        lCell.actionBtnDelete = {
            
            // Suppression de l'item
            lItem.delete()
            
        }
        
        // L'action de check
        lCell.actionBtnEtat = {
            
            // Si checké
            if lItem.etat == .checked {
                lItem.etat = .unchecked
            }
            else {
                lItem.etat = .checked
            }
            
            // Sauvegarde
            lItem.save()
            
        }
        
        // On renvoie la cellule configurée
        return lCell
        
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
