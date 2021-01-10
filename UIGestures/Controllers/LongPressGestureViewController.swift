//
//  LongPressGestureViewController.swift
//  UIGestures
//
//  Created by Jose Martins on 10/01/21.
//

import UIKit

class LongPressGestureViewController: UIViewController {
    @IBOutlet var vwLongPressView: UIView!
    @IBOutlet var vwBadge: UIView!
    
    @IBOutlet var vwBadgeWidthConstraint: NSLayoutConstraint!
    @IBOutlet var vwLongPressHeightConstraint: NSLayoutConstraint!
    @IBOutlet var vwLongPressWidthConstraint: NSLayoutConstraint!
    
    //-----------------------------------------------------------------------
    //    MARK: - UIViewController
    //-----------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGestures()
    }
    
    override func viewDidLayoutSubviews() {
        vwBadge.roundCorners(corners: [.topLeft, .bottomLeft], radius: 20)
    }
    
    //-----------------------------------------------------------------------
    //    MARK: - CustomMethods
    //-----------------------------------------------------------------------
    
    func configureGestures() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        
        longPressGesture.minimumPressDuration = 0.3
        vwLongPressView.addGestureRecognizer(longPressGesture)
        
        let tapOnBadgeGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapOnBadgeGesture.cancelsTouchesInView = false
        
        vwBadge.addGestureRecognizer(tapOnBadgeGesture)
    }
    
    @objc func handleLongPress(_ sender: UILongPressGestureRecognizer) {
        
        if sender.state == .began {
            UIView.animate(
                withDuration: 0.9,
                delay: 0,
                usingSpringWithDamping: 0.6,
                initialSpringVelocity: 1,
                options: UIView.AnimationOptions.curveEaseInOut
            ) {
                self.vwLongPressHeightConstraint.constant = 200
                self.vwLongPressWidthConstraint.constant = 200
                self.vwBadgeWidthConstraint.constant = 90
                self.view.layoutIfNeeded()
            }
        }    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        UIView.animate(
            withDuration: 0.9,
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 1,
            options: UIView.AnimationOptions.curveEaseInOut
        ) {
            self.vwLongPressHeightConstraint.constant = 240
            self.vwLongPressWidthConstraint.constant = 240
            self.vwBadgeWidthConstraint.constant = 0
            
            self.view.layoutIfNeeded()
        }
    }
}
