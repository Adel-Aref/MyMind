//
//  HomeViewController.swift
//  Report
//
//  Created by Mariam on 8/3/18.
//  Copyright © 2018 Mariam. All rights reserved.
//

import UIKit
import CHTCollectionViewWaterfallLayout



class HomeViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , CHTCollectionViewDelegateWaterfallLayout{
    
    
    let model = CollectionViewCellModel()
    //var currentUser = UserDefaults.standard.object(forKey: "CurrentUser") as! [String:Any]
    
    var Invoices = Bool()
    var Reports = Bool()
    var Money = Bool()
    var Analysis = Bool()
    var Inventory = Bool()
    var Earns = Bool()
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        homeCollectionView.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
        setupCollectionView()
        
        model.buildDataSource()
        
//        print(currentUser["Analysis"] as! Bool)
//
//        Invoices = currentUser["Invoices"] as! Bool
//        Reports = currentUser["Reports"] as! Bool
//        Money = currentUser["Money"] as! Bool
//        Analysis = currentUser["Analysis"] as! Bool
//        Inventory = currentUser["Inventory"] as! Bool
//        Earns = currentUser["Earns"] as! Bool
        
        
                Invoices = true
                Reports = true
                Money = true
                Analysis = true
                Inventory = true
                Earns = true
        print(Earns)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
extension HomeViewController{
    
    func setupCollectionView(){
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        
        let layout = CHTCollectionViewWaterfallLayout()
        // Change individual layout attributes for the spacing between cells
        layout.minimumColumnSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        
        // Collection view attributes
        self.homeCollectionView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        self.homeCollectionView.alwaysBounceVertical = true
        
        // Add the waterfall layout to your collection view
        self.homeCollectionView.collectionViewLayout = layout
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
        
        //        "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
        switch indexPath.row {
        case 0:
            cell.cellTitle.text = "الفواتير"
            cell.cellImageView.image = model.images[1]
            if ( Invoices == false){
                cell.isUserInteractionEnabled = false
            }
            
            
        case 1:
            cell.cellTitle.text = "التقارير"
            cell.cellImageView.image = model.images[2]
            if ( Reports == false){
                cell.isUserInteractionEnabled = false
            }
            
        case 2:
            cell.cellTitle.text = "الارباح و الضرائب"
            cell.cellImageView.image = model.images[2]
            if ( Earns == false){
                cell.isUserInteractionEnabled = false
            }
            
        case 3:
            cell.cellTitle.text = "الحركه اليوميه"
            cell.cellImageView.image = model.images[2]
            
            
        case 4:
            cell.cellTitle.text = "تحليل البيانات"
            cell.cellImageView.image = model.images[2]
            if ( Analysis == false){
                cell.isUserInteractionEnabled = false
            }
            
        case 5:
            cell.cellTitle.text = "النقديه"
            cell.cellImageView.image = model.images[2]
            if ( Money == false){
                cell.isUserInteractionEnabled = false
            }
            
        case 6:
            cell.cellTitle.text = "جرد المخازن"
            cell.cellImageView.image = model.images[2]
            if ( Inventory == false){
                cell.isUserInteractionEnabled = false
            }
            
        default:
            break
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        let imageSize = model.images[indexPath.row].size
        //
        //        return imageSize
        
        let width : CGFloat
        let height : CGFloat
        
        if indexPath.item == 0 {
            width = self.view.frame.size.width / 2
            height = width
        } else {
            width = self.view.frame.size.width / 2
            height = width/2
        }
        //return CGSizeMake(width, height)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "showInvoiceViewController", sender: nil)
        case 1:
            let storyboard : UIStoryboard = UIStoryboard(name: "AdelStoryboard", bundle: nil)
            let vc =  storyboard.instantiateViewController(withIdentifier: "reports") as! ReportVC
            
            self.show(vc, sender: nil)
        case 3:
            performSegue(withIdentifier: "showBondsViewController", sender: nil)
            
           
        case 2:
            let storyboard : UIStoryboard = UIStoryboard(name: "AdelStoryboard", bundle: nil)
            let vc =  storyboard.instantiateViewController(withIdentifier: "ProfitsVC") as! ProfitsVC
            self.show(vc, sender: nil)
            
            
        case 4:
            let storyboard : UIStoryboard = UIStoryboard(name: "AdelStoryboard", bundle: nil)
            let vc =  storyboard.instantiateViewController(withIdentifier: "DataAnalysisVC") as! DataAnalysisVC
            self.show(vc, sender: nil)
        case 5:
            performSegue(withIdentifier: "showSearchDataViewController", sender: nil)
            
        case 6:
            let storyboard : UIStoryboard = UIStoryboard(name: "AdelStoryboard", bundle: nil)
            let vc =  storyboard.instantiateViewController(withIdentifier: "StoresVC") as! StoresVC
            self.show(vc, sender: nil)
        default:
            break
        }
    }
    
    
}


