//
//  RotationGestureViewController.swift
//  UIGestures
//
//  Created by Jose Martins on 10/01/21.
//

import UIKit

class RotationGestureViewController: UIViewController {
    @IBOutlet var vwRotateMe: UIView!
    //-----------------------------------------------------------------------
    //    MARK: - UIViewController
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configGestures()
    }
    
    //-----------------------------------------------------------------------
    //    MARK: - CustomMethods
    //-----------------------------------------------------------------------
    
    func configGestures() {
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotationGesture))
        vwRotateMe.addGestureRecognizer(rotationGesture)
    }
    
    @objc func handleRotationGesture(_ sender: UIRotationGestureRecognizer) {
        
        if let view = sender.view {
            
            view.transform = view.transform.rotated(by: sender.rotation)
            sender.rotation = 0
            
//            sender.velocity
            
            if sender.state == .ended {
                UIView.animate(withDuration: 0.3) {
                    view.transform = CGAffineTransform(rotationAngle: 0)
                }
            }
            
        }
    }
}
