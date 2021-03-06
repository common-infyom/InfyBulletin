/**
 *  BulletinBoard
 *  Copyright (c) 2017 Alexis Aubry. Licensed under the MIT license.
 */

import UIKit
import InfyBulletin

/**
 * A subclass of page bulletin item that plays an haptic feedback when the buttons are pressed.
 *
 * This class demonstrates how to override `PageBulletinItem` to add custom button event handling.
 */

@available(iOS 10.0, *)
class FeedbackPageBulletinItem: PageBulletinItem {

    private let feedbackGenerator = UISelectionFeedbackGenerator()

     override func actionButtonTapped(sender: UIButton) {
        // Play an haptic feedback
        feedbackGenerator.prepare()
        feedbackGenerator.selectionChanged()
        // Call super
        super.actionButtonTapped(sender: sender)
    }

    override func alternativeButtonTapped(sender: UIButton) {
        // Play an haptic feedback
        feedbackGenerator.prepare()
        feedbackGenerator.selectionChanged()
        // Call super
        super.alternativeButtonTapped(sender: sender)
    }
}
