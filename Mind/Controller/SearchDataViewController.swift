//
//  SearchDataViewController.swift
//  Mind
//
//  Created by Mariam on 8/8/18.
//  Copyright © 2018 Mind. All rights reserved.
//

import UIKit

class SearchDataViewController: UIViewController {
    
    
    @IBOutlet weak var searchDataTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchDataViewController{
    func setupTableView(){
//        searchDataTableView.delegate = self
//        searchDataTableView.dataSource = self
    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        self.searchDataTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! SearchDataTableViewCell
//
//
//
//        return cell
//    }
}
