//
//  StoresVC.swift
//  Mind
//
//  Created by Adel on 8/9/18.
//  Copyright © 2018 Mind. All rights reserved.
//
import UIKit
class StoresVC: UIViewController , UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource{
    
    // outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerViewStores: UIPickerView!
    @IBOutlet weak var pickerViewTypes: UIPickerView!
    
    // define variables
    var selectedType:String = ""
    var selectedStore:String = ""
    var arrOfStores:[String] = []
    var aarOfTypes : [String] = ["عــــــــام","منتهي الصلاحية","غير منتهي الصلاحية","اوشك علي انتهاء الصلاحية","منتهي الكمية","اوشك علي انتهاء الكمية"]
    var arrayOfStoreModels:[StoreResultModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // to register store tableview cell
        let cellNib = UINib(nibName: "StoreSearch", bundle: nil)
      tableView.register(cellNib, forCellReuseIdentifier: "StoreSearch")
        let activity1 = HelpingMethods.showActivityIndicator(myView: self.view)
        StoreRequestViewModel.getStores { (success, error, stores) in
            if success
            {
                self.arrOfStores = stores
                self.pickerViewStores.reloadAllComponents()
                HelpingMethods.removeActivityIndicator(activityIndicator: activity1)
                print("stores : \(self.arrOfStores)")
            }
            else
            {
                HelpingMethods.removeActivityIndicator(activityIndicator: activity1)
                let alertController = UIAlertController(title: "انتبه", message: "يوجد مشكله في الاتصال بالانترنت", preferredStyle: .alert)
                
                // Create the actions
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                print("error :\(error)")
            }
        }
        // End of viewDidLoad
    }
    @IBAction func btnSarchPressed(_ sender: Any) {
        print("test")
        // type here your code
        let paremeters = ["Store_title":selectedStore,"kind":selectedType]
        let activity2 = HelpingMethods.showActivityIndicator(myView: self.view)
        StoreeSearchRequest.getStoreDetails(myParameters: paremeters) { (success, error, arrOfStoresModels) in
            if success {
                print("table data loaded")
                self.arrayOfStoreModels = arrOfStoresModels
                self.tableView.reloadData()
                HelpingMethods.removeActivityIndicator(activityIndicator: activity2)
            }
            else{
                print("failure")
                HelpingMethods.removeActivityIndicator(activityIndicator: activity2)
                let alertController = UIAlertController(title: "انتبه", message: "يوجد مشكله في الاتصال بالانترنت", preferredStyle: .alert)
                
                // Create the actions
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    ///
    // End of the calss
}
extension StoresVC{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerViewStores {
            return arrOfStores.count
        }
        else if pickerView == pickerViewTypes
        {
            return aarOfTypes.count
        }
        else
        {
            return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerViewStores {
            return arrOfStores[row]
        }
        else if pickerView == pickerViewTypes{
            return aarOfTypes[row]
        }
        else{
            return "test"
        }
    }
    /////
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerViewStores
        {
            selectedStore = arrOfStores[row]
            print("dfdf\(selectedStore)")
        }
        if pickerView == pickerViewTypes
        {
            switch row{
                
            case 0:
                selectedType = "عــــــــام"
            case 1:
                selectedType = "منتهى الصلاحية"
            case 2:
                selectedType = "غير منتهى الصلاحية"
            case 3:
                selectedType = "اوشك على انتهاء الصلاحية"
            case 4:
                selectedType = "منتهى الكمية"
            case 5:
                selectedType = "اوشك على انتهاء الكمية"
            default:
                selectedType = "test"
            }
        }
        
    }
    
}

// extenion to fil the tableView
extension StoresVC{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfStoreModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoreSearch")
            as? StoreSearch else {return UITableViewCell()}
        ///////
        let storeModelDetils = arrayOfStoreModels[indexPath.row]
        cell.lblAvailable.text = String(storeModelDetils.availble)
        cell.lblBuysTotal.text = String(storeModelDetils.buysTotal)
        cell.lblExpirationDate.text = String(describing: storeModelDetils.expirationDate)
        cell.lblLowestQntity.text = String(storeModelDetils.lowestQntity)
        cell.lblSalesTotal.text = String(storeModelDetils.salesTotal)
        cell.lblStoreName.text = storeModelDetils.storeName
        cell.lblType.text = storeModelDetils.type
        cell.lblTypeName.text = storeModelDetils.typeName
        return cell
    }
}
