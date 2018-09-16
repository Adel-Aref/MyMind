//
//  secondViewcontroller.swift
//  Mind
//
//  Created by Adel on 8/8/18.
//  Copyright © 2018 Mind. All rights reserved.
//

import UIKit

class DataAnalysisVC: UIViewController ,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource{
    @IBOutlet weak var pickerType: UIPickerView!
    @IBOutlet weak var pickerPeriod: UIPickerView!
    
    @IBOutlet weak var dateTo: UIDatePicker!

    @IBOutlet weak var txtQntity: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateFrom: UIDatePicker!

    @IBOutlet weak var txtResNumbers: UITextField!
    var arrayOfDataAnalysisModels:[DataAnalysisModel] = []
    var arrOfTypes:[String] = ["الاكثر مبيعاً","الاقل مبيعاً","الاكثر شراء","الاقل شراء"]
    var arrOfPeroids:[String] =  ["اليوم الحالي","اليوم السابق","الاسبوع الحالي","الاسبوع السابق","الشهر الحالي","الشهر السابق","العام الحالي","العام السابق"]
    var selectedType:String = ""
    var selectedPeriod:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "DataAnalysisCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "DataAnalysisCell")
        tableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSearchPressed(_ sender: Any) {
    
        print("date1 :\(dateFrom.date)")
        print("date1 :\(dateTo.date)")
        var resNumCorrect:Bool = false
        var qnttyCorrect:Bool = false
        
        if let qntity = txtQntity.text
        {
            let qnty = Int32(qntity)
            if qntity == "" || qnty! < 0 {
                let alertController = UIAlertController(title: "انتبه", message: "من فضلك ادخل عدد صحيح ", preferredStyle: .alert)
                
                // Create the actions
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    NSLog("OK Pressed")
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else {qnttyCorrect = true}
        }
        ///
        if let resNum = txtResNumbers.text
        {
            let resNumber = Int32(resNum)
            if resNum == "" || resNumber! < 1 {
                let alertController = UIAlertController(title: "انتبه", message: "من فضلك ادخل عدد صحيح ابكر من صفر", preferredStyle: .alert)
                
                // Create the actions
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    NSLog("OK Pressed")
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else {resNumCorrect = true}
        }
        /////////
        if selectedType == ""{
            let alertController = UIAlertController(title: "انتبه", message: "يجب اختيار احد الانواع", preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            
            let resNumm = Int(txtResNumbers.text!)
            let qntty = Int(txtQntity.text!)
            let paremeter = ["kind": "الاكثر مبيعاً",
                             "From_date": "2018-06-03 15:37:30 +0000",
                             "To_date": "2018-09-02T00:00:00",
                             "Limit": 8,
                             "qty": 1] as [String : Any]
            let paremeters = ["kind": selectedType,
                "From_date": dateFrom.date,
                "To_date": dateTo.date,
                "Limit": resNumm,
                "qty": qntty] as [String : Any]
            
            if resNumCorrect == true && qnttyCorrect == true
            {
                let activity1 = HelpingMethods.showActivityIndicator(myView: self.view)
                DataAnalysisRequest.getStoreDetails(myParameters: paremeters) { (success, error, arrOfDataAnlyModels) in
                    if success {
                        print("success")
                        self.arrayOfDataAnalysisModels = arrOfDataAnlyModels
                        self.tableView.reloadData()
                        HelpingMethods.removeActivityIndicator(activityIndicator: activity1)
                        // print("data :\( self.arrayOfDataAnalysisModels[0].category)")
                        
                    }
                    else{
                        print("failure")
                        HelpingMethods.removeActivityIndicator(activityIndicator: activity1)
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
        }
        
        // end of button action
    }
    
    // End of the class
}
//// Extenion
// extenion to fil the tableView
extension DataAnalysisVC{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfDataAnalysisModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DataAnalysisCell")
            as? DataAnalysisCell else {return UITableViewCell()}
        ///////
        let dataAnaysisModel = arrayOfDataAnalysisModels[indexPath.row]

        cell.lbltitleName.text = String(dataAnaysisModel.Item_title)
        cell.lblCategory.text = String(dataAnaysisModel.category)
        cell.lblBarcode1.text = String(describing: dataAnaysisModel.barcode1)
        cell.lblBarcode2.text = String(dataAnaysisModel.barcode2)
        cell.lblQntty.text = String(describing: dataAnaysisModel.qty)
        
        return cell
    }
}
// DataPickerView Extenion
extension DataAnalysisVC{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerType {
            return arrOfTypes.count
        }
        else if pickerView == pickerPeriod
        {
            return arrOfPeroids.count
        }
        else
        {
            return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerType {
            return arrOfTypes[row]
        }
            
        else if pickerView == pickerPeriod
        {
            return arrOfPeroids[row]
        }
            
        else
        {
            return "test"
        }
        
    }
    /////
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerType {
            selectedType = arrOfTypes[row]
        }
            
        else if pickerView == pickerPeriod
        {selectedPeriod = arrOfPeroids[row]
            let res =  HelpingMethods.claculateFromAndToDates(period: selectedPeriod, fromDate: dateFrom.date, toDate: dateTo.date)
            dateFrom.date = res[0]
            dateTo.date = res[1]
            
        }
        else
        {
            //return 1
        }
        
    }
    
}
