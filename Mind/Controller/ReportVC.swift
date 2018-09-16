//
//  ReportVC.swift
//  Mind
//
//  Created by Adel on 8/8/18.
//  Copyright © 2018 Mind. All rights reserved.
//

import UIKit

class ReportVC: UIViewController ,RequestViewModelDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource{
    
    
    @IBOutlet weak var pickerEmp: UIPickerView!
    @IBOutlet weak var pickerType: UIPickerView!
    @IBOutlet weak var pickerAccount: UIPickerView!
    @IBOutlet weak var dateFrom: UIDatePicker!
    @IBOutlet weak var dateTo: UIDatePicker!
    @IBOutlet weak var tableResults: UITableView!
    @IBOutlet weak var pickerPeroids: UIPickerView!
    
    
    // Define my variables
    var  arrOfBanks:[String] = []
    var  arrOfTreauries:[String] = []
    var  arrOfEmps:[String] = []
    var  arrOfAccounts:[String] = []
    var arrOfPeriods:[String] = ["اليوم الحالي","اليوم السابق","الاسبوع الحالي","الاسبوع السابق","الشهر الحالي","الشهر السابق","العام الحالي","العام السابق"]
    var  arrOfTypes:[String] = ["المبيعات","المشتريات","مرتجع البيع","مرتجع الشراء","صافي المبيعات","صافي المشتريات","الهالك","تحويل لمخزن"]
    var selectededEmp : String = ""
    var selectededAccount : String = ""
    var selectededPeriod : String = ""
    var selectededType : String = ""
    var returnQnty:Bool = false
    
    var arrayOfReports:[ReportModel] = []
    
    var viewModel = RequestViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        let cellNib = UINib(nibName: "reportCell", bundle: nil)
        tableResults.register(cellNib, forCellReuseIdentifier: "reportCell")
        tableResults.reloadData()
        
        //let actvity5 = HelpingMethods.showActivityIndicator(myView: self.view)
        TreasuryRequest.getTreaureies { (success, error, treasuries) in
            if success {
                self.arrOfTreauries = treasuries
                print("success : \(self.arrOfTreauries)")
            }
            else {
                print("Failure : ")
                
            }
        }
        // End of viewDidLoad
        ////////
        let activity1 = HelpingMethods.showActivityIndicator(myView: self.view)
        AccountRequestViewModel.getAccounts{ (success, error, accounts) in
            
            if success
            {
                self.arrOfAccounts = accounts
                self.pickerAccount.reloadAllComponents()
                HelpingMethods.removeActivityIndicator(activityIndicator: activity1)
                print("accounts : \(accounts)")
            }
            else
            {
                print("error :\(error)")
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
        ///
        let activity2 = HelpingMethods.showActivityIndicator(myView: self.view)
        EmpRequestViewModel.getEmps { (success, error, employees) in
            
            if success
            {
                self.arrOfEmps = employees
                self.pickerEmp.reloadAllComponents()
                HelpingMethods.removeActivityIndicator(activityIndicator: activity2)
                print("Emps : \(employees)")
            }
            else
            {
                print("error :\(error)")
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
        
     // End of main
    }
    
    @IBAction func btnSearchPressed(_ sender: UIButton) {

        print("selectededType \(selectededType)")
        
        if selectededType == ""{
            let alertController = UIAlertController(title: "انتبه", message: "يجب اختيار احد الانواع", preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            let activity3 = HelpingMethods.showActivityIndicator(myView: self.view)
            let paremeters = ["kind": selectededType,
                "From_date":  dateFrom.date,
                "To_date":dateTo.date,
                "Return_Qty": returnQnty,
                "E_name": selectededEmp,
                "Account_title": selectededAccount] as [String : Any]
            let paremeter = ["kind": "بيع"
                ] as [String : Any]
            print("dateFrom: \(dateFrom.date)")
            ReportRequest.getReportsDetails(myParameters: paremeters) { (success, error, reports) in
                if success {
                    self.arrayOfReports = reports
                    self.tableResults.reloadData()
                    HelpingMethods.removeActivityIndicator(activityIndicator: activity3)
                    print("Reports: \(reports)")
                }
                else{
            HelpingMethods.removeActivityIndicator(activityIndicator: activity3)
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
    
    // End of the class
}

// the extenion
extension ReportVC{

    func didSuccefull(banks: [String]) {
      
        print("success \(arrOfBanks.count)")
    }
    
    func didFailure(error: NetworkError, errorMessage: String) {
        print("error hapend  \(errorMessage)")
    }
    
    // End of extenion
}

extension ReportVC{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerEmp {
        return arrOfEmps.count
        }
        else if pickerView == pickerAccount
        {
            return arrOfAccounts.count
        }
        else if pickerView == pickerType
        {
            return arrOfTypes.count
        }
        else if pickerView == pickerPeroids
        {
            return arrOfPeriods.count
        }
        else
        {
            return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerEmp {
        return arrOfEmps[row]
        }
        else if pickerView == pickerAccount{
            return arrOfAccounts[row]
        }
        else if pickerView == pickerType
        {
            return arrOfTypes[row]
        }
        else if pickerView == pickerPeroids
        {
            return arrOfPeriods[row]
        }
        else{
            return "test"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerEmp {
            selectededEmp = arrOfEmps[row]
        }
        else if pickerView == pickerAccount{
            selectededAccount = arrOfAccounts[row]
        }
        else if pickerView == pickerType
        {
            switch row{
                
            case 0:
                returnQnty = false
                selectededType = "بيع"
            case 1:
                returnQnty = false
                selectededType = "شراء"
            case 2:
                returnQnty = false
                selectededType = "مرتجع بيع"
            case 3:
                returnQnty = false
                selectededType = "مرتجع شراء"
            case 4:
                returnQnty = true
                selectededType = "بيع"
            case 5:
                returnQnty = true
                selectededType = "شراء"
            case 6:
                returnQnty = false
                selectededType = "هالك"
            case 7:
                returnQnty = false
                selectededType = "تحويل لمخزن"
            default:
                returnQnty = false
                selectededType = arrOfTypes[row]
            }
        }
        else if pickerView == pickerPeroids
        {
            selectededPeriod = arrOfPeriods[row]
            let res =  HelpingMethods.claculateFromAndToDates(period: selectededPeriod, fromDate: dateFrom.date, toDate: dateTo.date)
            dateFrom.date = res[0]
            dateTo.date = res[1]
        }
        else{
            
        }
    }
}

// TableView Extenion
extension ReportVC{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfReports.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reportCell")
            as? reportCell else {return UITableViewCell()}
        ///////
        
        let report = arrayOfReports[indexPath.row]
        let prefixDate = String(String(describing: report.invoices_date).prefix(10))
        
        cell.lblMovingDate.text = prefixDate
        cell.lblNameCategory.text = report.Item_title
        //cell.lblEmp.text = String(describing: report.)
        cell.lblFinal.text = String(report.final)
        cell.lblPrice.text = String(describing: report.price)
        cell.lblProfit.text = String(report.earn)
        cell.lblQuntty.text = String(describing: report.qty)
        cell.lblUnit.text = String(report.unit)
        //cell.lblAccountName.text = String(describing: report)
        
        return cell
    }
}
