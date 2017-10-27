//
//  HomeViewController.swift
//  CustomBulletinBoard
//
//  Created by Dhvl Golakiya on 10/10/17.
//  Copyright © 2017 infyom. All rights reserved.
//

import UIKit
import InfyBulletin

class HomeViewController: UIViewController ,UINavigationControllerDelegate ,UITableViewDelegate ,UITableViewDataSource{

    
    @IBOutlet weak var tableView: UITableView!
    
    var arr = ["bmw","jaguar","lamborghini","mercedes","mustang","rolls"]
    
    var arr1 = ["BMW","Jaguar","Lamborghini","Mercedes","Mustang","Rolls Royace"]
    
    @available(iOS 10.0, *)
    lazy var bulletinManager: ListManager = {
        let rootItem: ListItem = BulletinDataSource.makeIntroPage() 
        return ListManager(rootItem: rootItem)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arr1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "creditCardTableCell") as? creditCardTableCell
        if (cell == nil) {
            let nib = Bundle.main.loadNibNamed("creditCardTableCell", owner: self, options: nil)
            cell = nib?[0] as? creditCardTableCell
        }
        cell?.imageDataView?.image = UIImage(named: arr[indexPath.row])
        cell?.label?.text = arr1[indexPath.row]
        
        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    override func viewWillAppear(_ animated: Bool) {
        animateTable()
    }
    
    func animateTable() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion:nil)
             index += 1
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            self.arr.remove(at: indexPath.row)
            self.arr1.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            self.tableView.reloadData()
        }
        //tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.count)
    }
    
    @IBAction func homeButton(_ sender: Any) {
        
            bulletinManager.prepare()
            bulletinManager.presentBulletin(above: self)
       
        
//        let textBlendScreen = BlurHomeViewController(nibName: "BlurHomeViewController", bundle: nil)
//        textBlendScreen.arr = self.arr
//        textBlendScreen.arr1 = self.arr1
//        self.navigationController?.pushViewController(textBlendScreen, animated: true)

        
    }
    
   
}
