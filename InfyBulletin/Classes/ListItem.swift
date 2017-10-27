//
//  ListItem.swift
//  CustomBulletinBoard
//
//  Created by Dhvl Golakiya on 16/10/17.
//  Copyright © 2017 infyom. All rights reserved.
//

import Foundation
import UIKit

public protocol ListItem: class {
    
    var manager: ListManager? { get set }
    
    var isDismissable: Bool { get set }
    
   
    var nextItem: ListItem? { get set }
    func tearDown()
    
    func makeArrangedSubviews() -> [UIView]

    
    
}
extension ListItem{
    
   
    
    public func displayNextItem() {
        
        guard let nextItem = self.nextItem else {
            return
        }
        
        manager?.push(item: nextItem)
        
    }
    
}

