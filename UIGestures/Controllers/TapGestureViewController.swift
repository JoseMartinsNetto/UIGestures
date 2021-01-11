//
//  TapGestureViewController.swift
//  UIGestures
//
//  Created by Jose Martins on 09/01/21.
//

import UIKit

class TapGestureViewController: UIViewController {
    @IBOutlet var vwShowModal: UIView!
    @IBOutlet var vwModal: UIView!
    @IBOutlet var vwModalOverlay: UIView!
    @IBOutlet var vwTapMe: UIView!
    
    @IBOutlet var lblTapMe: UILabel!
    
    @IBOutlet var vwModalHeightConstraint: NSLayoutConstraint!
    
    
    var isShowingModal: Bool = false
    var toggleChangeToGreen: Bool = false
    
    //-----------------------------------------------------------------------
    //    MARK:- UIViewController
    //-----------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupGestures()
    }
    
    override func viewDidLayoutSubviews() {
        vwModal.roundCorners(corners: [.topLeft, .topRight], radius: 50)
    }
    
    //-----------------------------------------------------------------------
    //    MARK:- Custom Methods
    //-----------------------------------------------------------------------
    
    func setupGestures() {
        let tapOnModalOverlayGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(handleTapOnModalOverlay))
        vwModalOverlay.addGestureRecognizer(tapOnModalOverlayGestureRecognizer)
        
        let tapOnCardGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapOnCard))
        //        tapOnCardGestureRecognizer.cancelsTouchesInView = touchesBegan, touchesEnded
        //        tapOnCardGestureRecognizer.buttonMaskRequired = .primary .secondary
        //        tapOnCardGestureRecognizer.numberOfTouchesRequired = 1, 2 ... fingers
        //        tapOnCardGestureRecognizer.numberOfTapsRequired = 1, 2 ... taps
        
        vwTapMe.addGestureRecognizer(tapOnCardGestureRecognizer)
        
    }
    
    func configUI() {
        vwShowModal.layer.borderWidth = 1
        vwShowModal.layer.borderColor = #colorLiteral(red: 0.3098039216, green: 0.7137254902, blue: 0.2705882353, alpha: 1)
        vwShowModal.layer.cornerRadius = 25
    }
    
    @objc func handleTapOnCard(_ sender: UITapGestureRecognizer) {
        toggleChangeToGreen = !toggleChangeToGreen
        
        UIView.animate(withDuration: 0.3) {
            if self.toggleChangeToGreen {
                self.vwTapMe.backgroundColor = #colorLiteral(red: 0.3098039216, green: 0.7137254902, blue: 0.2705882353, alpha: 1)
                self.lblTapMe.textColor = .white
            } else {
                self.vwTapMe.backgroundColor = .white
                self.lblTapMe.textColor = #colorLiteral(red: 0.1098039216, green: 0.1254901961, blue: 0.1607843137, alpha: 1)
            }
            
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func handleTapOnModalOverlay(_ sender: UITapGestureRecognizer) {
        toggleModal(forceClose: true)
    }
    
    func toggleModal(forceClose: Bool = false) {
        if forceClose {
            isShowingModal = false
        } else {
            isShowingModal = !isShowingModal
        }
        
        UIView.animate(
            withDuration: 0.9,
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 1,
            options: UIView.AnimationOptions.curveEaseInOut
        ) {
            if self.isShowingModal {
                self.vwModalOverlay.alpha = 0.8
                self.vwModalHeightConstraint.constant = 300
                
            } else {
                self.vwModalOverlay.alpha = 0
                self.vwModalHeightConstraint.constant = 0
            }
            
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func openModal(_ sender: UIButton) {
        toggleModal()
    }
    
    @IBAction func closeModal(_ sender: Any) {
        toggleModal(forceClose: true)
    }
}


