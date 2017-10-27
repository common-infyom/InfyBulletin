//
//  ListIntefaceFactory.swift
//  CustomBulletinBoard
//
//  Created by Dhvl Golakiya on 16/10/17.
//  Copyright © 2017 infyom. All rights reserved.
//

import UIKit
import Foundation

/**
 * Generates interface elements for bulletins. Use this class to create custom bulletin items witg
 * standard components.
 */

public class ListInterfaceFactory  {
    
    
    
    
    
    /**
     * Creates a new interface factory with the default configuration.
     */
    public init() {}
   
    
    // MARK: - Customization
    
    /// The tint color to apply to button elements.
    
    public var tintColor = UIColor.blue
    
    /// The title color to apply to action button.
    public var actionButtonTitleColor = UIColor.white
    
    
    // MARK: - Fonts
    
    /// The font size of title elements.
    public let titleFontSize: CGFloat = 30
    
    /// The font size of description labels.
    public let descriptionFontSize: CGFloat = 20
    
    /// The font size of compact description labels.
    public let compactDescriptionFontSize: CGFloat = 15
    
    /// The font size of action buttons.
    public let actionButtonFontSize: CGFloat = 17
    
    
    // MARK: - Colors
    
    /// The color of title text labels.
    public let titleTextColor = #colorLiteral(red: 0.568627451, green: 0.5647058824, blue: 0.5725490196, alpha: 1)
    public let tableLable = UIColor()
    public let tableButton = UIColor()
    /// The color of description text labels.
    public let descriptionTextColor = UIColor.black
    var items: [String] = ["BMW","Jaguar","Lamborghini","Mercedes","Mustang","Rolls Royace"]
//    var colors: [UIColor] = [UIColor.red ,UIColor.green ,UIColor.blue ,UIColor.brown ,UIColor.purple ,UIColor.cyan]
    // MARK: - Factories
    
    /**
     * Creates a standard title label.
     */
    
    public func makeTitleLabel() -> UILabel {
        
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        if titleLabel.textColor == nil{
            titleLabel.textColor = titleTextColor
        }
        
        titleLabel.accessibilityTraits |= UIAccessibilityTraitHeader
        titleLabel.numberOfLines = 1
        titleLabel.adjustsFontSizeToFitWidth = true
        
        if #available(iOS 8.2, *) {
            titleLabel.font = UIFont.systemFont(ofSize: titleFontSize, weight: UIFontWeightMedium)
        } else {
            // Fallback on earlier versions
        }
        
        return titleLabel
        
    }
     @available(iOS 11.0, *)
     func makeTableData(colorOne : UIColor ,  colorTwo : UIColor) -> UIView{
        
        
            let tableView = LoadTableView()
//            if tableView.tableButtonC == nil && tableView.tableLabelC == nil{
                tableView.tableLabelC = colorOne
                tableView.tableButtonC = colorTwo
                //        }
                
        //}
        tableView.frame = CGRect(x: 0, y: 0, width: 200, height: 400)
        tableView.setContantView()

        return tableView
    }
   
    /**
     * Creates a standard title label.
     *
     * - parameter isCompact: If `true`, a smaller font size will be used.
     */
    
     func makeDescriptionLabel(isCompact: Bool) -> UILabel {
        
        let descriptionLabel = UILabel()
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = descriptionTextColor
        descriptionLabel.numberOfLines = 0
        
        let fontSize: CGFloat = isCompact ? compactDescriptionFontSize : descriptionFontSize
        descriptionLabel.font = UIFont.systemFont(ofSize: fontSize)
        
        return descriptionLabel
        
    }
     func makeTempView(isCompact : Bool) -> UIView{
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 200, height: 400)
        tempView.backgroundColor = UIColor.clear
        tempView.layer.borderWidth = 2.0
        return tempView
    }
    
    /**
     * Creates a standard action (main) button.
     *
     * The created button will have rounded corners, a background color set to the `tintColor` and
     * a title color set to `actionButtonTitleColor`.
     *
     * - parameter title: The title of the button.
     */
    
     func makeActionButton(title: String) -> ListContainerView<HighlightButton> {
        
        let actionButton = HighlightButton(type: .custom)
        if actionButton.backgroundColor == nil{
            actionButton.setBackgroundColor(tintColor, forState: .normal)
            actionButton.setTitleColor(actionButtonTitleColor, for: .normal)
        }
        actionButton.contentHorizontalAlignment = .center
        actionButton.autoresizingMask = .flexibleWidth
        
        actionButton.setTitle(title, for: .normal)
        if #available(iOS 8.2, *) {
            actionButton.titleLabel?.font = UIFont.systemFont(ofSize: actionButtonFontSize, weight: UIFontWeightSemibold)
        } else {
            // Fallback on earlier versions
        }
        
        actionButton.layer.cornerRadius = 12
        actionButton.clipsToBounds = true
        
        let actionContainer = ListContainerView<HighlightButton>(actionButton)
        if #available(iOS 9.0, *) {
            actionContainer.heightAnchor.constraint(equalToConstant: 55).isActive = true
        } else {
            // Fallback on earlier versions
        }
        
        return actionContainer
        
    }
    
    /**
     * Creates a standard alternative button.
     *
     * The created button will have no background color and a title color set to `tintColor`.
     *
     * - parameter title: The title of the button.
     */
    
     func makeAlternativeButton(title: String) -> UIButton {
        
        let alternativeButton = UIButton(type: .custom)
        if alternativeButton.backgroundColor == nil{
            alternativeButton.setTitle(title, for: .normal)
            alternativeButton.setTitleColor(tintColor, for: .normal)
        }
        
        
        return alternativeButton
        
    }
    
    /**
     * Creates a stack view to contain a group of objects.
     *
     * - parameter spacing: The spacing between elements. Defaults to `10`.
     */
    
    @available(iOS 9.0, *)
     func makeGroupStack(spacing: CGFloat = 10) -> UIStackView {
        
       
            var buttonsStack = UIStackView()
            buttonsStack.axis = .vertical
            buttonsStack.alignment = .fill
            buttonsStack.distribution = .fill
            buttonsStack.spacing = spacing
  
       
        
        return buttonsStack
        
    }
    
}

// MARK: - Swift Compatibility

#if swift(>=4.0)
    @available(iOS 8.2, *)
    private let UIFontWeightMedium = UIFont.Weight.medium
    @available(iOS 8.2, *)
    private let UIFontWeightSemibold = UIFont.Weight.semibold
#endif

