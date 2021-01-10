//
//  PinchGestureViewController.swift
//  UIGestures
//
//  Created by Jose Martins on 10/01/21.
//

import UIKit

class PinchGestureViewController: UIViewController {
    @IBOutlet var vwPinchMe: UIView!
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
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture))
        
        pinchGesture.scale = 0.5
        
        vwPinchMe.addGestureRecognizer(pinchGesture)
    }
    
    @objc func handlePinchGesture(_ sender: UIPinchGestureRecognizer) {
        
        if let view = sender.view {
            view.transform = view.transform.scaledBy(x: sender.scale, y: sender.scale)
            sender.scale = 1.0
            
            if sender.state == .ended {
                UIView.animate(withDuration: 0.3) {
                    sender.view?.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
            }
        }
        
    }
}
