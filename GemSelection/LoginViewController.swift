//
//  LoginViewController.swift
//  GemSelection
//
//  Created by Bimlesh Singh on 12/08/17.
//  Copyright © 2017 ITS. All rights reserved.
//

import UIKit
import Firebase
import FacebookCore
import FacebookLogin
import GoogleSignIn
import FBSDKLoginKit

class LoginViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    
    var appUser : User?
    var ref: DatabaseReference!

    @IBOutlet var signInView: UIView!
    @IBOutlet var facebookButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        ref = Database.database().reference()
        signupBtn.setTitleColor(UIColor.black, for: .normal)
        signInView.frame = CGRect(x: 16, y: 227, width: self.view.frame.size.width/1.09, height: self.view.frame.size.height/3.92)
        signupBtn.setTitleColor(UIColor.gray, for: .normal)
        self.view.addSubview(signInView)
        googleButton.addTarget(self, action: #selector(handleGoogleSignin), for: .touchUpInside)
        googleButton.layer.cornerRadius = 5
        facebookButton.addTarget(self, action: #selector(handleFacebook), for: .touchUpInside)
    }
    
    @IBOutlet weak var signinBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    @IBAction func signUpButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "signupSegue", sender: self)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        
        print(user.profile.email)
        print(user.profile.givenName!)
        
        
        
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                // ...
                print(error ?? "some error")
                return
            }
            // User is signed in
            // ...
            
            
            
            print(authResult?.user.displayName)
            print(authResult?.user.email)
            if let fname = user.profile.givenName, let lname = user.profile.familyName, let mail = user.profile.email{
                self.appUser = User(mail: mail, first_name: fname, last_name: lname, id:1 as? Int)
            }
            
            DispatchQueue.main.async{
                isloggedin = 1
                self.performSegue(withIdentifier: "signinsuccess", sender: self)
                
            }
            
         
        }
    }
    
    @objc func handleGoogleSignin(){
        print("SIGNING IN .........")
        GIDSignIn.sharedInstance().signIn()
    }
    
    @objc func handleFacebook(){
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .email], viewController: self) { (result) in
            switch result {
            case .failed(let error):
                print("ERROR......")
                print(error.localizedDescription)
            case .cancelled:
                print("user cancelled")
            case .success(_,_,_):
                self.getUserInfo(completion: { (userInfo, err) in
                    if let error = err{
                        print(error.localizedDescription)
                    }
                    
                    print(userInfo!)
                    
                    if let userInfo = userInfo, let firstName = userInfo["first_name"], let lastName = userInfo["last_name"], let mailId = userInfo["email"], let id = userInfo["id"]{
                        self.appUser = User(mail: mailId as? String, first_name: firstName as? String, last_name: lastName as? String, id: id as? Int)
                        print("reached")
                        
                        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                            if let error = error {
                                // ...
                                print(error)
                                return
                            }
                            
                            print(authResult?.user.displayName)
                            print(authResult?.user.email)
                            
                            DispatchQueue.main.async{
                                isloggedin = 1
                                self.performSegue(withIdentifier: "signinsuccess", sender: self)
                                
                            }
                        }
                        
                    }
                })
            }
        }
    }
    
    func getUserInfo(completion: @escaping (_ : [String: Any]?, _ : Error?) -> Void){
        let parameters = ["fields" : "id, email, first_name, last_name"]
        let result = GraphRequest(graphPath: "me", parameters: parameters)
        result.start { (response, result) in
            switch result{
            case .failed(let error):
                print(error.localizedDescription)
                completion(nil, error)
            case .success(response: let graphResponse):
                completion(graphResponse.dictionaryValue, nil)
            }
            
        }
    }
    
    
    @IBAction func signInAction(_ sender: Any) {
        
        guard let email = signInEmail.text else {
            return
        };guard let password = signInPassword.text else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error!.localizedDescription)}
            else{
                print("\n\nsignin")
                isloggedin = 1
                self.performSegue(withIdentifier: "signinsuccess", sender: self)
            }
        }
    }
    
    @IBAction func dismissViewController(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var signInEmail: UITextField!
    @IBOutlet weak var signInPassword: UITextField!

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        signInEmail.resignFirstResponder()
        signInPassword.resignFirstResponder()
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
        
     override var shouldAutorotate: Bool {
            return false
        }
    }



class forgotViewController: UIViewController {
    override func viewDidLoad() {
        
    }
    @IBAction func facebookSignin(_ sender: UIButton) {
    }
    
    
    @IBAction func sendResetBtn(_ sender: Any) {
            guard let email = forgotEmailTF.text else {
                return
            }
            Auth.auth().sendPasswordReset(withEmail: email) { (Error) in
                if Error != nil{
                    print(Error!.localizedDescription)}
                else{
                    self.performSegue(withIdentifier: "signinsegue", sender: self)
                }
            }}
    
    
    
    @IBOutlet weak var forgotEmailTF: UITextField!

}




