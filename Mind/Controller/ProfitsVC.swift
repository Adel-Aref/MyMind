//
//  ProfitsVC.swift
//  Mind
//
//  Created by Adel on 8/12/18.
//  Copyright © 2018 Mind. All rights reserved.
//

import UIKit

class ProfitsVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    @IBOutlet weak var pickerPeriod: UIPickerView!
    @IBOutlet weak var fromDate: UIDatePicker!
    @IBOutlet weak var endDate: UIDatePicker!
    @IBOutlet weak var lblBad: UIButton!
    @IBOutlet weak var Sale_tax: UIButton!
    @IBOutlet weak var lblTotal_earn: UIButton!
    @IBOutlet weak var lblSale_earn: UIButton!
    @IBOutlet weak var Total_tax: UIButton!
    @IBOutlet weak var Buy_tax: UIButton!
    @IBOutlet weak var lblExpenes: UIButton!
    
    var arrOfProfit:[String:Double] = [:]
    var arrOfPeriods:[String] = ["اليوم الحالي","اليوم السابق","الاسبوع الحالي","الاسبوع السابق","الشهر الحالي","الشهر السابق","العام الحالي","العام السابق"]
    var selectedPeriod :String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Sale_earn.setTitle("asd", for: .normal)
        // Do any additional setup after loading the view.
        // Hi
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func fillProfitData(arrayOfProfit:[String:Any])
    {
        lblSale_earn.setTitle(String(describing: self.arrOfProfit["Sale_earn"] ?? 1.1), for: .normal)
        lblBad.setTitle(String(describing: self.arrOfProfit["Bad"] ?? 1.1), for: .normal)
        Buy_tax.setTitle(String(describing: self.arrOfProfit["Buy_tax"] ?? 1.1), for: .normal)
        lblExpenes.setTitle(String(describing: self.arrOfProfit["Expenes"] ?? 1.1), for: .normal)
        Total_tax.setTitle(String(describing: self.arrOfProfit["Total_tax"] ?? 1.1), for: .normal)
        lblTotal_earn.setTitle(String(describing: self.arrOfProfit["Bad"] ?? 1.1), for: .normal)
        Sale_tax.setTitle(String(describing: self.arrOfProfit["Sale_tax"] ?? 1.1), for: .normal)
    }
    @IBAction func btnSearchPressed(_ sender: Any) {

        let res =  HelpingMethods.claculateFromAndToDates(period: selectedPeriod, fromDate: fromDate.date, toDate: endDate.date)
        fromDate.date = res[0]
        endDate.date = res[1]
        print("testttt1:\(fromDate.date)")
        print("testttt2:\(endDate.date)")
        let fromDateString = String(describing: fromDate.date )
        let toDateString = String(describing: endDate.date )
        print("from \(fromDateString) to \(toDateString)")
        
        // to run the indicator
        let activity1 = HelpingMethods.showActivityIndicator(myView: self.view)
        // type here your code
        let paremeters = ["From_date":fromDateString,"To_date":toDateString]
        ProfitRequest.getProfitDetails(myParameters: paremeters) { (success, error, ProfitModels) in
           
            if success {
                self.arrOfProfit = ProfitModels
                self.fillProfitData(arrayOfProfit: self.arrOfProfit)
                HelpingMethods.removeActivityIndicator(activityIndicator: activity1)
                print("Profit Model :\(self.arrOfProfit)")
            }
            else {
                print("Error Happend !")
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
    
    // End of the class
}

// Extenion

extension ProfitsVC{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return arrOfPeriods.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
            return arrOfPeriods[row]
    }
    /////
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
            selectedPeriod = arrOfPeriods[row]
        let res =  HelpingMethods.claculateFromAndToDates(period: selectedPeriod, fromDate: fromDate.date, toDate: endDate.date)
        fromDate.date = res[0]
        endDate.date = res[1]
            print("selected peroid\(selectedPeriod)")
    }
    
}
///
// extenion to fil the tableView

