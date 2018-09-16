//
//  LoginViewController.swift
//  Mind
//
//  Created by Mariam on 8/12/18.
//  Copyright © 2018 Mind. All rights reserved.
//

import UIKit
import MBProgressHUD
import CoreData

class LoginViewController: UIViewController {
    
    
    
    
    @IBOutlet var usernameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func didTapLogin(_ sender: Any) {
        if (usernameTextField.hasText) {
            let userDefaults = UserDefaults.standard
            userDefaults.setValue(usernameTextField.text, forKey: "password")
            userDefaults.synchronize()
            
            //coredata
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
            //let newUser = NSManagedObject(entity: entity!, insertInto: context)
            // Do any additional setup after loading the view.
            //
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            //request.predicate = NSPredicate(format: "age = %@", "12")
            request.returnsObjectsAsFaults = false
            do {
                let result = try context.fetch(request)
                for data in result as! [NSManagedObject] {
                    let url=(data.value(forKey: "url") as! String)
                    let p=(data.value(forKey: "password") as! String)
                    
                    if usernameTextField.text == p{
                        performSegue(withIdentifier: "goToHome", sender: nil)
                    }
                    
                    
                }
                
            } catch {
                
                print("Failed")
            }
            performSegue(withIdentifier: "goToURL", sender: nil)
        }}
    
}
