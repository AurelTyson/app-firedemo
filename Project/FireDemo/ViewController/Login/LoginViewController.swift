//
//  LoginViewController.swift
//  FireDemo
//
//  Created by Aurélien Tison on 03/11/2016.
//  Copyright © 2016 aureltyson. All rights reserved.
//

import UIKit
import ActionKit
import FBSDKLoginKit
import Firebase

open class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    // MARK: - Constantes
    
    // MARK: - Attributs graphiques
    
    @IBOutlet weak var labelInformations: UILabel!
    
    @IBOutlet weak var textFieldLogin: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet weak var btnSeConnecter: UIButton!
    @IBOutlet weak var btnInscrire: UIButton!
    @IBOutlet weak var btnFacebook: FBSDKLoginButton!
    
    // MARK: - Attributs
    
    // MARK: - View
    
    public init() {
        super.init(nibName: "LoginViewController", bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // On affiche pas le petit clavier pour masquer le grand
        self.view.dontUseDefaultRetractViewAsDodgeViewForMLInputDodger = false
        
        // Vidage du label d'informations
        self.labelInformations.text = ""
        
        // Le bouton de connexion
        self.btnSeConnecter.addControlEvent(.touchUpInside) {
            
            // Le login
            let lLogin = self.textFieldLogin.text!
            
            // Le password
            let lPassword = self.textFieldPassword.text!
            
            // Connexion
            FIRAuth.auth()?.signIn(withEmail: lLogin, password: lPassword, completion: { (user: FIRUser?, error: Error?) in
                
                // Si connexion ok
                guard user != nil else {
                    self.labelInformations.text = "Erreur de connexion"
                    return
                }
                
                // Check de connexion
                self.checkConnexion()
                
            })
            
        }
        
        // Le bouton d'inscription
        self.btnInscrire.addControlEvent(.touchUpInside) {
            
            // Le login
            let lLogin = self.textFieldLogin.text!
            
            // Le password
            let lPassword = self.textFieldPassword.text!
            
            // Création de l'utilisateur
            FIRAuth.auth()?.createUser(withEmail: lLogin, password: lPassword, completion: { (user: FIRUser?, error: Error?) in
                
                // Si création ok
                if user != nil {
                    self.labelInformations.text = "Inscription ok 😎"
                }
                else {
                    self.labelInformations.text = "Erreur d'inscription 🙁"
                }
                
            })
            
        }
        
        // Le bouton Facebook
        self.btnFacebook.delegate = self
        
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
        
        // Check de connexion
        self.checkConnexion()
        
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
    
    fileprivate func checkConnexion() {
        
        // Si user déjà connecté
        guard let lUser = FIRAuth.auth()?.currentUser else {
            return
        }
        
        // La vue de liste d'items
        let lNextVC = UINavigationController(rootViewController: ListeItemsViewController(user: lUser))
        
        // Affichage
        self.present(lNextVC, animated: true, completion: nil)
        
    }
    
    // MARK: - FBSDKLoginButtonDelegate
    
    open func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            
            // Check de connexion
            self.checkConnexion()
            
        }
        
    }
    
    open func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
        NSLog(">> Déconnexion")
        
    }
    
}
