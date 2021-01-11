//
//  SwipeGestureViewController.swift
//  UIGestures
//
//  Created by Jose Martins on 10/01/21.
//

import UIKit

class SwipeGestureViewController: UIViewController {
    @IBOutlet var vwModalOverlay: UIView!
    @IBOutlet var vwModal: UIView!
    @IBOutlet var vwShowModal: UIView!
    @IBOutlet var lblSwipeMe: UILabel!
    
    @IBOutlet var vwModalHeightConstraint: NSLayoutConstraint!
    //-----------------------------------------------------------------------
    //    MARK: - UIViewController
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configGestures()
    }
    
    override func viewDidLayoutSubviews() {
        vwModal.roundCorners(corners: [.topLeft, .topRight], radius: 50)
    }
    
    //-----------------------------------------------------------------------
    //    MARK: - CustomMethods
    //-----------------------------------------------------------------------
    
    func configGestures() {
        let swipeDownOnModalRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleDownSwipeOnModal))
        swipeDownOnModalRecognizer.direction = .down
//        swipeDownOnModalRecognizer.numberOfTouchesRequired = 1,2 .. fingers
        vwModal.addGestureRecognizer(swipeDownOnModalRecognizer)
        
        let swipeUpOnModalRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleUpSwipeOnModal))
        swipeUpOnModalRecognizer.direction = .up
        vwModal.addGestureRecognizer(swipeUpOnModalRecognizer)
    }
    
   @IBAction func showModal(_ sender: UITapGestureRecognizer) {
        UIView.animate(
            withDuration: 0.9,
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 1,
            options: UIView.AnimationOptions.curveEaseInOut
        ) {
            self.lblSwipeMe.text = "Swipe me up"
            self.vwModalHeightConstraint.constant = 80
            self.view.layoutIfNeeded()
        }
        
    }
    
    @objc func handleUpSwipeOnModal(_ sender: UISwipeGestureRecognizer) {
        UIView.animate(
            withDuration: 0.9,
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 1,
            options: UIView.AnimationOptions.curveEaseInOut
        ) {
            self.lblSwipeMe.text = "Swipe me down"
            self.vwModalHeightConstraint.constant = 200
            self.vwModalOverlay.alpha = 0.7
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func handleDownSwipeOnModal(_ sender: UISwipeGestureRecognizer) {
        UIView.animate(
            withDuration: 0.9,
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 1,
            options: UIView.AnimationOptions.curveEaseInOut
        ) {
            self.lblSwipeMe.text = "Swipe me up"
            self.vwModalHeightConstraint.constant = 80
            self.vwModalOverlay.alpha = 0
            self.view.layoutIfNeeded()
        }
        
    }
    
}
