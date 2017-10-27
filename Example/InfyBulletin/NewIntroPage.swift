//
//  NewIntroPage.swift
//  BulletinBoardExample
//
//  Created by Dhvl Golakiya on 09/10/17.
//  Copyright © 2017 infyom. All rights reserved.
//

import UIKit
import Foundation
import InfyBulletin

enum BulletinDataSource {

    static func makeIntroPage() -> FeedbackPageBulletinItem {
        let page = FeedbackPageBulletinItem(title: "Welcome to InfyOm")
        page.tableLableColor = UIColor.green
        page.tableBackButtonColor = UIColor.cyan
        page.interfaceFactory.tintColor = UIColor.red
        page.imageAccessibilityLabel = "😻"
        page.descriptionText = "Discover curated images of the best Apps  in Surat."
        page.actionButtonTitle = "GoNext"
        page.titleColor = UIColor.green
        page.imageAccessibilityLabel = "Discover curated Apps  in Surat."
        page.isDismissable = false
        
        page.actionHandler = { item in
            item.displayNextItem()
        }
        
        page.nextItem = makeNotitificationsPage()
        
        return page
    }

    static func makeNotitificationsPage() -> FeedbackPageBulletinItem {
        
        let page = FeedbackPageBulletinItem(title: "Payment Mode")
        page.image = UIImage(named : "lamborghini")
        page.titleColor = UIColor.cyan
        page.interfaceFactory.tintColor = UIColor.green
        page.imageAccessibilityLabel = "Notifications Icon"
        page.descriptionText = "Receive push notifications when new photos of pets are available."
        page.actionButtonTitle = "Credit Card"
        page.alternativeButtonTitle = "NetBanking"
        
        page.isDismissable = false
        
        page.actionHandler = { item in
           // PermissionsManager.shared.requestLocalNotifications()
            item.displayNextItem()
        }
        
        page.alternativeHandler = { item in
            
            page.nextItem = makeNetBanking()
            item.displayNextItem()
        }
        
        page.nextItem = makeLocationPage()
        
        return page
        
    }
    @available(iOS 10.0, *)
    static func makeLocationPage() -> FeedbackPageBulletinItem {
        
        let page = FeedbackPageBulletinItem(title: "Customize Feed")
        page.image = UIImage(named : "bmw")
        page.interfaceFactory.tintColor = UIColor.purple
        page.imageAccessibilityLabel = "Location Icon"
        page.descriptionText = "We can use your location to customize the feed. This data will be sent to our servers anonymously. You can update your choice later in the app settings."
        page.actionButtonTitle = "Send Credit Card Data"
        page.alternativeButtonTitle = "No thanks"
        
        page.shouldCompactDescriptionText = true
        page.isDismissable = true
        
        page.actionHandler = { item in
            item.displayNextItem()
        }
        
        page.alternativeHandler = { item in
           item.isDismissable = true
        }
        
        return page
        
    }
    @available(iOS 10.0, *)
    static func makeNetBanking() -> FeedbackPageBulletinItem {
        
        let page = FeedbackPageBulletinItem(title: "NetBanking Feed")
        page.image = UIImage(named : "mercedes")
        page.imageAccessibilityLabel = "Location Icon"
        
        page.descriptionText = "Kindly fill up ur netbanking details so that your payment can be done."
        page.actionButtonTitle = "Send NetBanking Data"
        page.alternativeButtonTitle = "No thanks"
        
        page.shouldCompactDescriptionText = true
        page.isDismissable = true
        
        page.actionHandler = { item in
            //item.manager?.displayActivityIndicator()
            //item.interfaceFactory.makeGroupStack(spacing: 2.0)
            //PermissionsManager.shared.requestWhenInUseLocation()
            
            item.displayNextItem()
        }
        
        page.alternativeHandler = { item in
            item.isDismissable = true
        }
        
        //        page.nextItem = makeGroupStack()
        
        return page
        
    }
   
    func colorButton(
        withColor color:UIColor,
        title:String) -> UIButton
    {
        let newButton = UIButton(type: .system)
        newButton.backgroundColor = color
        newButton.setTitle(
            title,
            for: .normal)
        newButton.setTitleColor(
            UIColor.white,
            for: .normal)
        return newButton
    }
//    static func makeChoicePage() -> PetSelectorBulletinPage {
//        return PetSelectorBulletinPage()
//    }
    static func makeCompletionPage() -> PageBulletinItem {
        
        let page = PageBulletinItem(title: "Setup Completed")
        //page.image = #imageLiteral(resourceName: "IntroCompletion")
        page.imageAccessibilityLabel = "Checkmark"
//        page.interfaceFactory.tintColor = #colorLiteral(red: 0.2941176471, green: 0.8509803922, blue: 0.3921568627, alpha: 1)
        //page.interfaceFactory.actionButtonTitleColor = .white
        //page.interfaceFactory.makeTableData()
        page.descriptionText = "Instanimal is ready for you to use. Happy browsing!"
        page.actionButtonTitle = "Get started"
        page.alternativeButtonTitle = "Replay"
        
        page.isDismissable = true
        
        page.actionHandler = { item in
            item.manager?.dismissBulletin(animated: true)
          //  NotificationCenter.default.post(name: .SetupDidComplete, object: item)
        }
        
        page.alternativeHandler = { item in
            item.manager?.popToRootItem()
        }
        
        return page
        
    }
   

    
}

