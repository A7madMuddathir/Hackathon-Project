//
//  Algorithms.swift
//  EalanatElSaudia
//
//  Created by   Hassan goda on 8/29/19.
//  Copyright © 2019  Hassan goda. All rights reserved.
//

import Foundation
import UIKit

// create btn action without func
typealias UIButtonTargetClosure = (UIButton) -> ()

let red = UIColor(hexString: "#E24700")
let yellow = UIColor(hexString: "#E9C201")
let green = UIColor(hexString: "#34BE82")

class ClosureWrapper: NSObject {
    let closure: UIButtonTargetClosure
    init(_ closure: @escaping UIButtonTargetClosure) {
        self.closure = closure
    }
}
extension UIButton {

    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }

    private var targetClosure: UIButtonTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? ClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, ClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func addTargetClosure(closure: @escaping UIButtonTargetClosure) {
        targetClosure = closure
        addTarget(self, action: #selector(UIButton.closureAction), for: .touchUpInside)
    }

    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure(self)
    }
}
//// to segue between vc
class Segue: UIViewController {


    func goNav(_ vc : String)  {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: vc)
        navigationController?.pushViewController(vc, animated: true)
    }

    func goMenu(_ vc : String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: vc)
        navigationController?.popToViewController(vc, animated: true)
    }

    func goNavFromLeft (_ vc: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: vc)
        navigationController?.view.layer.add(CATransition().segueFromLeft(), forKey: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    func dismissNav()  {
        navigationController?.popViewController(animated: true)
    }
    func goVC(_ vc : String)  {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: vc)
        self.present(vc, animated: true, completion: nil)

    }

    func dismissVC()  {
        dismiss(animated: true, completion: nil)
    }
}
////
//import SideMenu
//func presentMenuView(for vc: UIViewController, withIdentifier id: String){
//    //    let window = UIApplication.shared.keyWindow!
//    //    window.set(rootViewController: MainViewController)
//    //    vc.dismiss(animated: true, completion: nil)
//    let VC1 = vc.storyboard?.instantiateViewController(withIdentifier: id)
//    let menuRightNavigationController = UISideMenuNavigationController(rootViewController: VC1!)
//    SideMenuManager.default.menuRightNavigationController = menuRightNavigationController
//    SideMenuManager.default.menuFadeStatusBar = false
//    vc.present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
//}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func applyShadow(colour: CGColor) {
        self.layer.shadowColor = colour
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
    }
}

extension CATransition {

//New viewController will appear from bottom of screen.
func segueFromBottom() -> CATransition {
    self.duration = 0.375 //set the duration to whatever you'd like.
    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    self.type = CATransitionType.moveIn
    self.subtype = CATransitionSubtype.fromTop
    return self
}
//New viewController will appear from top of screen.
func segueFromTop() -> CATransition {
    self.duration = 0.375 //set the duration to whatever you'd like.
    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    self.type = CATransitionType.moveIn
    self.subtype = CATransitionSubtype.fromBottom
    return self
}
 //New viewController will appear from left side of screen.
func segueFromLeft() -> CATransition {
    self.duration = 0.5 //set the duration to whatever you'd like.
    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    self.type = CATransitionType.moveIn
    self.subtype = CATransitionSubtype.fromLeft
    return self
}
//New viewController will pop from right side of screen.
func popFromRight() -> CATransition {
    self.duration = 0.1 //set the duration to whatever you'd like.
    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    self.type = CATransitionType.reveal
    self.subtype = CATransitionSubtype.fromRight
    return self
}
//New viewController will appear from left side of screen.
func popFromLeft() -> CATransition {
    self.duration = 0.1 //set the duration to whatever you'd like.
    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    self.type = CATransitionType.reveal
    self.subtype = CATransitionSubtype.fromLeft
    return self
   }
}
//
