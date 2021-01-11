//
//  PanGestureViewController.swift
//  UIGestures
//
//  Created by Jose Martins on 09/01/21.
//

import UIKit

enum PanGestureEndAction {
    case up
    case down
    case left
    case right
}

class PanGestureViewController: UIViewController {
    @IBOutlet var vwDragMe: UIView!
    @IBOutlet var vwEffectBlur: UIVisualEffectView!
    
    @IBOutlet var imgPanImage: UIImageView!
    
    var originalPanImageCenter: CGPoint!
    
    //-----------------------------------------------------------------------
    //    MARK: - UIViewController
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configGestures()
    }
    
    
    //-----------------------------------------------------------------------
    //    MARK: -  Custom Methods
    //-----------------------------------------------------------------------
    
    func configGestures() {
        let panGestureOnDragMe = UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureOnDragMe))
        vwDragMe.addGestureRecognizer(panGestureOnDragMe)
        
        let panGestureOnPanImage = UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureOnPanImage))
        imgPanImage.addGestureRecognizer(panGestureOnPanImage)
        
        originalPanImageCenter = CGPoint(x: imgPanImage.center.x, y: imgPanImage.center.y)
    }
    
    @objc func handlePanGestureOnPanImage(_ sender: UIPanGestureRecognizer) {
        let point = sender.translation(in: view)
        let limit = imgPanImage.bounds.height / 2
        var yAxis: CGFloat = 0
        
        UIView.animate(withDuration: 0.3) {
            self.imgPanImage.backgroundColor = .white
        }
        
        if point.y < 0 {
            yAxis = point.y * -1
        } else {
            yAxis = point.y
        }
        
        if yAxis < limit {
            imgPanImage.layer.cornerRadius = yAxis
        }
        
        imgPanImage.center = CGPoint(x: originalPanImageCenter.x + point.x, y: originalPanImageCenter.y + point.y)
        
        if sender.state == .ended {
            UIView.animate(withDuration: 0.3) {
                self.imgPanImage.layer.cornerRadius = 0
                self.imgPanImage.center = self.originalPanImageCenter
                self.imgPanImage.backgroundColor = .clear
            }
        }
    }
    
    @objc func handlePanGestureOnDragMe(_ sender: UIPanGestureRecognizer) {
        if let viewTapMe = sender.view {
            let point = sender.translation(in: view)
            
            let rotationAngle = point.x / view.bounds.width * 0.4
            viewTapMe.transform = CGAffineTransform(rotationAngle: rotationAngle)
            
            viewTapMe.center =  CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
            
            if rotationAngle < 0 {
                vwEffectBlur.alpha = rotationAngle * 5 * -1
            } else {
                vwEffectBlur.alpha = rotationAngle * 5
            }
            
            if sender.state == .ended {
                
                if viewTapMe.center.x > self.view.bounds.width + 10 {
                    endUserAnimation(for: .right, rotationAngle: rotationAngle)
                    return
                }
                
                if viewTapMe.center.x < -10 {
                    endUserAnimation(for: .left, rotationAngle: rotationAngle)
                    return
                }
                
                if viewTapMe.center.y > self.view.bounds.width + 200 {
                    endUserAnimation(for: .down, rotationAngle: rotationAngle)
                    return
                }
                
                if viewTapMe.center.y < 200 {
                    endUserAnimation(for: .up, rotationAngle: rotationAngle)
                    return
                }
                
                UIView.animate(withDuration: 0.3) {
                    viewTapMe.center = self.view.center
                    viewTapMe.transform = CGAffineTransform(rotationAngle: 0)
                    self.vwEffectBlur.alpha = 0
                }
            }
        }
        
    }
    
    func endUserAnimation(for endAction: PanGestureEndAction, rotationAngle: CGFloat) {
        var center: CGPoint = CGPoint(x: 0, y: 0)
        var transform = CGAffineTransform(rotationAngle: CGFloat(0))
        
        switch endAction {
        case .down:
            center = CGPoint(x: vwDragMe.center.x, y: vwDragMe.center.x + self.view.bounds.height)
        case .up:
            center = CGPoint(x: vwDragMe.center.x, y: vwDragMe.center.x - self.view.bounds.height)
        case .left:
            center = CGPoint(x: vwDragMe.center.x - self.view.bounds.width, y: vwDragMe.center.y + 50)
            transform = CGAffineTransform(rotationAngle: rotationAngle)
        case .right:
            center = CGPoint(x: vwDragMe.center.x + self.view.bounds.width, y: vwDragMe.center.y + 50)
            transform = CGAffineTransform(rotationAngle: rotationAngle)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.vwDragMe.center = center
            self.vwDragMe.transform = transform
            self.vwEffectBlur.alpha = 0
        }
    }
}
