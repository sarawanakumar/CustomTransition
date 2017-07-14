//
//  ViewController.swift
//  TransitionAnimations
//
//  Created by Sarawanak on 7/14/17.
//  Copyright © 2017 Sarawanak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var destVC :UIViewController!
    var animator = TransitioningAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func performTransition(_ sender: UIButton) {
        configureDestVC()
        switch sender.currentTitle! {
        case "Fade In":
            destVC.transitioningDelegate = self
            animator.animation = .fadeIn
            
        case "Curve Linear":
            destVC.transitioningDelegate = self
            animator.animation = .curveLinear
            
        case "Curve Ease In":
            destVC.transitioningDelegate = self
            animator.animation = .curveEaseIn
        default:
            ()
        }
        self.present(destVC, animated: true, completion: nil)
    }
    
    func configureDestVC() -> () {
        destVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "destination")
        destVC.view.backgroundColor = UIColor.random
        
        let gestRec = UITapGestureRecognizer()
        gestRec.numberOfTapsRequired = 1
        gestRec.cancelsTouchesInView = false
        gestRec.addTarget(self, action: #selector(destinationViewTapped))
        destVC.view.addGestureRecognizer(gestRec)
    }
    
    func destinationViewTapped() -> () {
        self.destVC.dismiss(animated: true, completion: nil)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
}

extension UIColor {
    
    private static var colorCode: Float {
        return Float(arc4random_uniform(256))
    }
    
    static var random: UIColor{
        return UIColor(colorLiteralRed: colorCode / 255, green: colorCode / 255, blue: colorCode / 255, alpha: 1.0)
    }
}

