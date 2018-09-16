//
//  URLViewController.swift
//  Mind
//
//  Created by Mariam on 8/12/18.
//  Copyright © 2018 Mind. All rights reserved.
//

import UIKit
import MBProgressHUD
import CoreData

class URLViewController: UIViewController , urlRequestDelegate{
    
    
    
    
    @IBOutlet var urlTextField: UITextField!
    let viewModel = urlRequest()
    
    
    //let loginRequest = LoginRequest(with: UserDefaults.standard.object(forKey: "password") as! String)
    
    let password = UserDefaults.standard.object(forKey: "password")  as! String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewModel.delegate = self
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //    @IBAction func didTapSave(sender: AnyObject) {
    //
    ////        MBProgressHUD.showAdded(to: view, animated: true)
    ////
    ////
    ////        loginRequest.loginRequest(userId: urlTextField.text!)
    ////
    ////        MBProgressHUD.hide(for: view, animated: true)
    //        print(urlTextField.text , password)
    //
    //    }
    //
    
    @IBAction func didTapSave(_ sender: Any) {
        if urlTextField.hasText{
            viewModel.getUser(userURL: urlTextField.text!, password: password)
        }
    }
    
}

extension URLViewController{
    func didSuccefull(user: [String:Any]) {
        UserDefaults.standard.set(user, forKey: "CurrentUser")
        
        
        //save in core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue(password, forKey: "password")
        newUser.setValue(urlTextField.text, forKey: "url")
        
        do{
            try context.save()
        }
        catch{
            print("error")
        }
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let url=(data.value(forKey: "url") as! String)
                let p=(data.value(forKey: "password") as! String)
                
            }
            
        } catch {
            
            print("Failed")
        }
        
        performSegue(withIdentifier: "goToHome", sender: nil)
        
    }
    
    func didFailure(error: Error, errorMessage: String) {
        print("Enter correct password & url")
    }
}
