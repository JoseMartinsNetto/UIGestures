//
//  MultipleGesturesViewController.swift
//  UIGestures
//
//  Created by Jose Martins on 11/01/21.
//

import UIKit

class MultipleGesturesViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet var vwMultiGestures: UIView!
    //-----------------------------------------------------------------------
    //    MARK: - UIViewController
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGestures()
    }
    
    //-----------------------------------------------------------------------
    //    MARK: - UIGestureRecognizerDelegate
    //-----------------------------------------------------------------------
    
    
    //    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    //        return true
    //    }
    //
    //    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    //        return true
    //    }
    //
    //    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool {
    //        return true
    //    }
    //
    //    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
    //        return true
    //    }
    //
    //    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    //        return true
    //    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        // If the gesture recognizer's view isn't vwMultiGestures, do not allow simultaneous recognition.
        if gestureRecognizer.view != self.vwMultiGestures {
            return false
        }
        
        // If the gesture recognizers are on diferent views, do not allow simultaneous recognition.
        if gestureRecognizer.view != otherGestureRecognizer.view {
            return false
        }
        
        // If either gesture recognizer is a long press, do not allow simultaneous recognition.
        
//        if !(gestureRecognizer is UIRotationGestureRecognizer) || !(gestureRecognizer is UIPinchGestureRecognizer)
//        || !(otherGestureRecognizer is UIRotationGestureRecognizer) || !(otherGestureRecognizer is UIPinchGestureRecognizer){
//            return false
//        }
        
        
        
        return true
        
    }
    
    //    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    //        return true
    //    }
    
    //-----------------------------------------------------------------------
    //    MARK: - CustomMethods
    //-----------------------------------------------------------------------
    
    func  configureGestures() {
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        
        rotateGesture.delegate = self
        pinchGesture.delegate = self
        
        vwMultiGestures.addGestureRecognizer(rotateGesture)
        vwMultiGestures.addGestureRecognizer(pinchGesture)
        
    }
    
    @objc func handleRotation(_ sender: UIRotationGestureRecognizer) {
        if let view = sender.view {
            
            view.transform = view.transform.rotated(by: sender.rotation)
            sender.rotation = 0
            
            if sender.state == .ended {
                UIView.animate(withDuration: 0.3) {
                    view.transform = CGAffineTransform(rotationAngle: 0)
                }
            }
            
        }
    }
    
    @objc func handlePinch(_ sender: UIPinchGestureRecognizer) {
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
