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
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerV = transitionContext.containerView
        //let fromV = transitionContext.view(forKey: UITransitionContextViewKey.from)
        let toV = transitionContext.view(forKey: UITransitionContextViewKey.to)
        let originFrame = CGRect.zero
        let finalFrame = toV?.frame
        
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
            toV?.frame = originFrame
            containerV.addSubview(toV!)
            
            UIView.animate(withDuration: transDuration, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.curveLinear, animations: { 
                toV?.frame = finalFrame!
            }, completion: { (_) in
                self.isDestinationPresented = !self.isDestinationPresented
                transitionContext.completeTransition(true)
            })
            
        case .curveEaseIn:
            toV?.frame = originFrame
            containerV.addSubview(toV!)
            
            UIView.animate(withDuration: transDuration, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.curveEaseIn, animations: {
                toV?.frame = finalFrame!
            }, completion: { (_) in
                self.isDestinationPresented = !self.isDestinationPresented
                transitionContext.completeTransition(true)
            })

        }
        
    }
}
