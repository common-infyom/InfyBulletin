//
//  tableViewSegue.swift
//  CustomBulletinBoard
//
//  Created by Dhvl Golakiya on 23/10/17.
//  Copyright © 2017 infyom. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
class tableViewSegue: UIView {

    var contentString = String()
    var imageView = UIImage()
    var tableLabel : UIColor = UIColor.clear
    var tableBack : UIColor = UIColor.clear

    func setContantView(){
        self.backgroundColor = UIColor.white
        let backButton = UIButton()
        let label : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        
//        let imageNew = UIImage(named : "goback.png")
//        backButton.setTitle("go", for: .normal)
        
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(UIColor.white, for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        
//        let heightContraints = NSLayoutConstraint(item: backButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 30)
//        let widthContraints = NSLayoutConstraint(item: backButton, attribute:
//            .width, relatedBy: .equal, toItem: nil,
//                    attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0,
//                    constant: 70)
//        backButton.addConstraints([widthContraints, heightContraints])
        
        backButton.layer.cornerRadius = 8.0
//        backButton.titleRect(forContentRect: CGRect(x: 0, y: 0, width: 70, height: 30))
        backButton.backgroundColor = tableBack
        backButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        backButton.isUserInteractionEnabled = true
        
        self.addSubview(backButton)
    
        
        //label.center = CGPoint(x: label.frame.width , y: label.frame.height)
        label.textAlignment = NSTextAlignment.center
//        let LheightContraints = NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 30)
//        let LwidthContraints = NSLayoutConstraint(item: label, attribute:
//            .width, relatedBy: .equal, toItem: nil,
//                    attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0,
//                    constant: 70)
//        label.addConstraints([LwidthContraints, LheightContraints])
        
        label.text = contentString
        label.textColor = tableLabel
        label.center.x = self.center.x
        label.isUserInteractionEnabled = false
        self.addSubview(label)
        
        var imageViewObject = UIImageView()
        imageViewObject = UIImageView(frame: CGRect(x: 0 , y: 0, width: 230, height: 150))

        print(imageViewObject.frame.width)

        imageViewObject.center.y = self.center.y + backButton.center.y
        imageViewObject.center.x = self.center.x
        imageViewObject.image = imageView
        imageViewObject.isUserInteractionEnabled = false
//        let IheightContraints = NSLayoutConstraint(item: imageViewObject, attribute: .height, relatedBy: .equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 150)
//        let IwidthContraints = NSLayoutConstraint(item: imageViewObject, attribute:
//            .width, relatedBy: .equal, toItem: nil,
//                    attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0,
//                    constant: 250)
//        imageViewObject.addConstraints([IwidthContraints, IheightContraints])
        self.addSubview(imageViewObject)
//        
//        backButton.center.x = label.center.y
//        backButton.center.y = label.center.y
        
    }
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        self.removeFromSuperview()
    }
    
    
}
