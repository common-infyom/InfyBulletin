//
//  ListManager.swift
//  CustomBulletinBoard
//
//  Created by Dhvl Golakiya on 16/10/17.
//  Copyright © 2017 infyom. All rights reserved.
//

import Foundation
import UIKit
@available(iOS 9.0, *)
public final class ListManager: NSObject, UIViewControllerTransitioningDelegate {
    
    /// The view controller displaying the bulletin.
    private let viewController: ListViewController
    
    // MARK: - Private Properties
    
    private let rootItem: ListItem
    
    private var itemsStack: [ListItem]
    private var currentItem: ListItem
    private var previousItem: ListItem?
    
    private var isPrepared: Bool = false
    private var isPreparing: Bool = false
    
    // MARK: - Initialization
    
    /**
     * Creates a bulletin manager with the list of items to display.
     *
     * An item represents the contents available on a single card.
     *
     * - parameter items: The items to display.
     */
    
    public init(rootItem: ListItem) {
        
        self.rootItem = rootItem
        self.itemsStack = []
        self.currentItem = rootItem
        
        self.viewController = ListViewController()
        
    }
    
    // MARK: - Interacting with the Bulletin
    
    /**
     * Prepares the bulletin iterface and displays the root item.
     */
    
    public func prepare() {
        
        precondition(Thread.isMainThread)
        
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = self
        viewController.manager = self
        
        isPrepared = true
        isPreparing = true
        
        displayCurrentItem()
        isPreparing = false
        
    }
    
    /**
     * Hides the contents of the stack and displays a black activity indicator view.
     *
     * Use this method if you need to perform a long task or fetch som edata before changing the item.
     *
     * Displaying the loading indicator does not change the height of the page. Call one of `push(item:)`,
     * `popItem` or `popToRootItem` to hide the activity indicator and change the current item.
     */
    
//    public func displayActivityIndicator() {
//        
//        precondition(Thread.isMainThread)
//        precondition(isPrepared, "You must call the `prepare` function before interacting with the bulletin.")
//        
//        viewController.displayActivityIndicator()
//        
//    }
    
    /**
     * Displays a new item after the current one.
     * - parameter item: The item to display.
     */
    
    public func push(item: ListItem) {
        
        precondition(Thread.isMainThread)
        
        previousItem = currentItem
        itemsStack.append(item)
        
        currentItem = item
        displayCurrentItem()
        
    }
    
    /**
     * Removes the current item from the stack and displays the previous item.
     */
    
    public func popItem() {
        
        precondition(Thread.isMainThread)
        
        guard let previousItem = itemsStack.popLast() else {
            popToRootItem()
            return
        }
        
        self.previousItem = previousItem
        
        guard let currentItem = itemsStack.last else {
            popToRootItem()
            return
        }
        
        self.currentItem = currentItem
        displayCurrentItem()
        
    }
    
    /**
     * Removes all the items from the stack and displays the root item.
     */
    
    public func popToRootItem() {
        
        precondition(Thread.isMainThread)
        
        guard currentItem !== rootItem else {
            return
        }
        
        previousItem = currentItem
        currentItem = rootItem
        
        itemsStack = []
        
        displayCurrentItem()
        
    }
    
    // MARK: - Presentation / Dismissal
    
    /**
     * Presents the bulletin above the specified view controller.
     *
     * - parameter presentingVC: The view controller to use to present the bulletin.
     * - parameter animated: Whether to animate presentation. Defaults to `true`.
     * - parameter completion: An optional block to execute after presentation. Default to `nil`.
     */
    
    public func presentBulletin(above presentingVC: UIViewController,
                                animated: Bool = true,
                                completion: (() -> Void)? = nil) {
        
        precondition(Thread.isMainThread)
        precondition(isPrepared, "You must call the `prepare` function before interacting with the bulletin.")
        
        presentingVC.present(viewController, animated: animated, completion: completion)
        
    }
    
    /**
     * Dismisses the bulletin and clears the current page.
     *
     * - parameter animated: Whether to animate dismissal. Defaults to `true`.
     * - parameter completion: An optional block to execute after dismissal. Default to `nil`.
     */
    
    public func dismissBulletin(animated: Bool = true,
                                completion: (() -> Void)? = nil) {
        
        precondition(Thread.isMainThread)
        precondition(isPrepared, "You must call the `prepare` function before interacting with the bulletin.")
        
        currentItem.tearDown()
        currentItem.manager = nil
        
        viewController.dismiss(animated: animated) {
            
            completion?()
            
            for arrangedSubview in self.viewController.contentStackView.arrangedSubviews {
                self.viewController.contentStackView.removeArrangedSubview(arrangedSubview)
                arrangedSubview.removeFromSuperview()
            }
            
            self.viewController.resetContentView()
            
        }
        
        currentItem = rootItem
        tearDownItemsChain(startingAt: self.rootItem)
        itemsStack.removeAll()
        
        viewController.manager = nil
        viewController.transitioningDelegate = nil
        
        isPrepared = false
        
    }
    
    /// Returns the presentation controller for the bulletin view controller.
    public func presentationController(forPresented presented: UIViewController,
                                       presenting: UIViewController?,
                                       source: UIViewController) -> UIPresentationController? {
        
        precondition(Thread.isMainThread)
        
        if presented is ListViewController {
            return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
        }
        
        return nil
        
    }
    
    // MARK: - Management
    
    private func displayCurrentItem() {
        
        precondition(isPrepared, "You must call the `prepare` function before interacting with the bulletin.")
        viewController.isDismissable = false
        
        // Tear down old item
        
        let oldArrangedSubviews = viewController.contentStackView.arrangedSubviews
        
        previousItem?.tearDown()
        previousItem?.manager = nil
        previousItem = nil
        
        currentItem.manager = self
        
        // Create new views
        
        let newArrangedSubviews = currentItem.makeArrangedSubviews()
        
        for arrangedSubview in newArrangedSubviews {
            arrangedSubview.isHidden = isPreparing ? false : true
            viewController.contentStackView.addArrangedSubview(arrangedSubview)
        }
        
        // Animate transition
        
        let animationDurationFactor: Double = isPreparing ? 0 : 1
        
        let initialAlphaAnimationDuration = 0.25 * animationDurationFactor
        
        let initialAlphaAnimations = {
            
            //self.viewController.hideActivityIndicator()
            
            for arrangedSubview in oldArrangedSubviews {
                arrangedSubview.alpha = 0
            }
            
            for arrangedSubview in newArrangedSubviews {
                arrangedSubview.alpha = 0
            }
            
        }
        
        let transitionAnimationDuration = 0.25 * animationDurationFactor
        
        let transitionAnimation = {
            
            for arrangedSubview in oldArrangedSubviews {
                arrangedSubview.isHidden = true
            }
            
            for arrangedSubview in newArrangedSubviews {
                arrangedSubview.isHidden = false
            }
            
        }
        
        let finalAlphaAnimationDuration = 0.25 * animationDurationFactor
        
        let finalAlphaAnimation = {
            
            for arrangedSubview in newArrangedSubviews {
                arrangedSubview.alpha = 1
            }
            
        }
        
        UIView.animate(withDuration: initialAlphaAnimationDuration, animations: initialAlphaAnimations) { _ in
            
            UIView.animate(withDuration: transitionAnimationDuration, animations: transitionAnimation) { _ in
                
                self.viewController.contentStackView.alpha = 1
                
                UIView.animate(withDuration: finalAlphaAnimationDuration, animations: finalAlphaAnimation) { _ in
                    
                    self.viewController.isDismissable = self.currentItem.isDismissable
                    
                    for arrangedSubview in oldArrangedSubviews {
                        self.viewController.contentStackView.removeArrangedSubview(arrangedSubview)
                        arrangedSubview.removeFromSuperview()
                    }
                    
                    UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, newArrangedSubviews.first)
                    
                }
                
            }
            
        }
        
    }
    
    private func tearDownItemsChain(startingAt item: ListItem) {
        
        item.tearDown()
        
        if let nextItem = item.nextItem {
            tearDownItemsChain(startingAt: nextItem)
        }
        
    }
    
}

