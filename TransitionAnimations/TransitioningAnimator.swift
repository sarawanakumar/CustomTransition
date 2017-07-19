//
//  TransitioningAnimator.swift
//  TransitionAnimations
//
//  Created by Sarawanak on 7/14/17.
//  Copyright © 2017 Sarawanak. All rights reserved.
//

import Foundation
import UIKit

enum Animation {
    case fadeIn
    case curveLinear
    case curveEaseIn
}

class TransitioningAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var animation: Animation!
    var transDuration = 2.0
    var isDestinationPresented = false
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerV = transitionContext.containerView
        let fromV = transitionContext.view(forKey: UITransitionContextViewKey.from)
        let toV = transitionContext.view(forKey: UITransitionContextViewKey.to)
        let destinationView = isDestinationPresented ? fromV : toV
        let initialFrame = isDestinationPresented ? destinationView?.frame : originFrame
        let finalFrame = isDestinationPresented ? CGRect.zero : destinationView?.frame
        let xScaleFactor = !isDestinationPresented ? (initialFrame?.width)! / (finalFrame?.width)! : (finalFrame?.width)! / (initialFrame?.width)!
        let yScaleFactor = !isDestinationPresented ? (initialFrame?.height)! / (finalFrame?.height)! : (finalFrame?.height)! / (initialFrame?.height)!
        
        switch animation! {
        case .fadeIn:
            toV?.alpha = 0.0
            containerV.addSubview(toV!)
            
            UIView.animate(withDuration: transDuration, animations: {
                toV?.alpha = 1.0
            }) { (_) in
                transitionContext.completeTransition(true)
            }
            
        case .curveLinear:
            let transform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
            containerV.addSubview(toV!)
            containerV.bringSubview(toFront: destinationView!)
            
            if !isDestinationPresented {
                destinationView?.transform = transform
                destinationView?.center = CGPoint(x: (initialFrame?.midX)!, y: (initialFrame?.midY)!)
                destinationView?.clipsToBounds = true
            }
            
            //containerV.transform = transform
            
            UIView.animate(withDuration: transDuration, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.curveLinear, animations: { 
                destinationView?.transform = self.isDestinationPresented ? transform : CGAffineTransform.identity
                destinationView?.center = CGPoint(x: (finalFrame?.midX)!, y: (finalFrame?.midY)!)
                //toV?.frame = finalFrame!
            }, completion: { (_) in
                self.isDestinationPresented = !self.isDestinationPresented
                transitionContext.completeTransition(true)
            })
            
        case .curveEaseIn:
            let transform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
            containerV.addSubview(toV!)
            containerV.bringSubview(toFront: destinationView!)
            
            if !isDestinationPresented {
                destinationView?.transform = transform
                destinationView?.center = CGPoint(x: (initialFrame?.midX)!, y: (initialFrame?.midY)!)
                destinationView?.clipsToBounds = true
            }
            
            //containerV.transform = transform
            
            UIView.animate(withDuration: transDuration, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                destinationView?.transform = self.isDestinationPresented ? transform : CGAffineTransform.identity
                destinationView?.center = CGPoint(x: (finalFrame?.midX)!, y: (finalFrame?.midY)!)
                //toV?.frame = finalFrame!
            }, completion: { (_) in
                self.isDestinationPresented = !self.isDestinationPresented
                transitionContext.completeTransition(true)
            })
        }
        
    }
}
