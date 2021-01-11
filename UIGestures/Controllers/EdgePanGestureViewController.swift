//
//  EdgePanGestureViewController.swift
//  UIGestures
//
//  Created by Jose Martins on 10/01/21.
//

import UIKit

class EdgePanGestureViewController: UIViewController {
    @IBOutlet var vwRightEdgeBadge: UIView!
    @IBOutlet var vwLeftEdgeBadge: UIView!
    
    @IBOutlet var vwRightEdgeBadgeWidthConstrait: NSLayoutConstraint!
    @IBOutlet var vwLeftEdgeBadgeWidthConstrait: NSLayoutConstraint!
    //-----------------------------------------------------------------------
    //    MARK: - UIViewController
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configGestures()
    }
    
    override func viewDidLayoutSubviews() {
        vwRightEdgeBadge.roundCorners(corners: [.topLeft, .bottomLeft], radius: 50)
        vwLeftEdgeBadge.roundCorners(corners: [.topRight, .bottomRight], radius: 50)
    }
    
    //-----------------------------------------------------------------------
    //    MARK: - Custom Methods
    //-----------------------------------------------------------------------
    
    func configGestures() {
        let edgePanLeft = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePanLeft.edges = .left
        view.addGestureRecognizer(edgePanLeft)
        
        let edgePanRight = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePanRight.edges = .right
        view.addGestureRecognizer(edgePanRight)
    }
    
    @objc func screenEdgeSwiped(_ sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .recognized {
            
            UIView.animate(
                withDuration: 0.9,
                delay: 0,
                usingSpringWithDamping: 0.6,
                initialSpringVelocity: 1,
                options: UIView.AnimationOptions.curveEaseInOut
            ) {
                if sender.edges == .left {
                    self.vwLeftEdgeBadgeWidthConstrait.constant = 90
                }
                
                if sender.edges == .right {
                    self.vwRightEdgeBadgeWidthConstrait.constant = 90
                }
                
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func closeRightBadge(_ sender: Any) {
        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.9,
            options: UIView.AnimationOptions.curveEaseInOut
        ) {
            self.vwRightEdgeBadgeWidthConstrait.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func closeLeftBadge(_ sender: Any) {
        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.9,
            options: UIView.AnimationOptions.curveEaseInOut
        ) {
            self.vwLeftEdgeBadgeWidthConstrait.constant = 0
            self.view.layoutIfNeeded()
        }
    }
}
