//
//  ListContainerView.swift
//  CustomBulletinBoard
//
//  Created by Dhvl Golakiya on 16/10/17.
//  Copyright © 2017 infyom. All rights reserved.
//

import Foundation
import UIKit

/**
 * A view containing a subview, known as the content view.
 *
 * The four edges of the content view are pinned to the container. You can specifiy insets to move the
 * edges of the content view inside the container.
 */

public class ListContainerView<V>: UIView where V: UIView {
    
    private var topConstraint: NSLayoutConstraint!
    private var bottomConstraint: NSLayoutConstraint!
    private var leftConstraint: NSLayoutConstraint!
    private var rightConstraint: NSLayoutConstraint!
    
    /// The view inside the container.
    public let contentView: V
    
    /**
     * Wraps a view inside a container.
     * - parameter view: The subview to use as the content view
     */
    
    public init(_ view: V) {
        
        self.contentInset = .zero
        self.contentView = view
        
        super.init(frame: .zero)
        addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 9.0, *) {
            topConstraint = contentView.topAnchor.constraint(equalTo: topAnchor)
        } else {
            // Fallback on earlier versions
        };if #available(iOS 9.0, *) {
            topConstraint = contentView.topAnchor.constraint(equalTo: topAnchor)
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 9.0, *) {
            bottomConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        } else {
            // Fallback on earlier versions
        };if #available(iOS 9.0, *) {
            bottomConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 9.0, *) {
            leftConstraint = contentView.leftAnchor.constraint(equalTo: leftAnchor)
        } else {
            // Fallback on earlier versions
        };if #available(iOS 9.0, *) {
            leftConstraint = contentView.leftAnchor.constraint(equalTo: leftAnchor)
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 9.0, *) {
            rightConstraint = contentView.rightAnchor.constraint(equalTo: rightAnchor)
        } else {
            // Fallback on earlier versions
        };if #available(iOS 9.0, *) {
            rightConstraint = contentView.rightAnchor.constraint(equalTo: rightAnchor)
        } else {
            // Fallback on earlier versions
        }
        
        topConstraint.isActive = true
        bottomConstraint.isActive = true
        leftConstraint.isActive = true
        rightConstraint.isActive = true
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("ContainerView must be initialized with a view using the init(_:) initalizer.")
    }
    
    // MARK: - Insets
    
    /// The spacing between the edges of the container and those of the content view.
    public var contentInset: UIEdgeInsets {
        didSet {
            updateInsets()
        }
    }
    
    private func updateInsets() {
        topConstraint.constant = contentInset.top
        bottomConstraint.constant = -(contentInset.bottom)
        leftConstraint.constant = contentInset.left
        rightConstraint.constant = -(contentInset.right)
    }
}
