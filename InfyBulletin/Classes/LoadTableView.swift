//
//  LoadTableView.swift
//  CustomBulletinBoard
//
//  Created by Dhvl Golakiya on 23/10/17.
//  Copyright © 2017 infyom. All rights reserved.
//

import UIKit
import QuartzCore

@available(iOS 11.0, *)
class LoadTableView: UIView ,UITableViewDataSource ,UITableViewDelegate ,UIGestureRecognizerDelegate{
    
    var tableView = UITableView()
    var carNames = ["bmw","jaguar","lamborghini","mercedes","mustang","rolls"]
    var carImages = ["bmw","jaguar","lamborghini","mercedes","mustang","rolls"]
    var tableLabelC : UIColor = UIColor.clear
    var tableButtonC : UIColor = UIColor.clear
    
    func setContantView(){
        tableView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        tableView.autoresizingMask = [.flexibleWidth , .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
//        let recognizer = UITapGestureRecognizer(target: self, action: "didSwipe")
//        recognizer.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isUserInteractionEnabled = true
        tableView.allowsSelection = true
        tableView.reloadData()
        self.addSubview(tableView)
    }
    @objc func didSwipe(recognizer: UITapGestureRecognizer) {
         tableView.reloadData()
        let tapLocation = recognizer.location(in: self.tableView)
        if let tapIndexPath = tableView.indexPathForRow(at: tapLocation) {
            if self.tableView.cellForRow(at: tapIndexPath) != nil {
                print("You selected cell #\(tapIndexPath.row)!")
                
                let segueView = tableViewSegue()
                segueView.tableLabel = tableLabelC
                segueView.tableBack = tableButtonC
                segueView.contentString = carNames[tapIndexPath.row]
                segueView.imageView = UIImage(named: carImages[tapIndexPath.row])!
                
                segueView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
                segueView.setContantView()
//                segueView.center = self.center
                //segueView.backgroundColor = UIColor.darkGray
                self.addSubview(segueView)
                }
            }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carNames.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didSwipe))
        tapGesture.delegate = self
        cell.textLabel?.text = self.carImages[indexPath.row]
        cell.textLabel?.textColor = UIColor.black
        print(self.carImages[indexPath.row])

        self.addGestureRecognizer(tapGesture)
        return cell
    }
  
    
   
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("You selected cell #\(indexPath.row)!")
//        //let segueView = Bundle.main.loadNibNamed("tableViewSegue", owner: self, options: nil)?[0] as? tableViewSegue
//
//        segueView.contentString = carNames[indexPath.row]
//        segueView.imageView = UIImage(named: carImages[indexPath.row])!
//        segueView.setContantView()
//
//        //segueView.carImageView.image = UIImage(named: carImages[indexPath.row])
//        segueView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
//        tableView.reloadData()
//        self.addSubview(segueView)
//    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("You DEselected cell #\(indexPath.row)!")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
