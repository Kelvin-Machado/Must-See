//
//  Fade.swift
//  Must-See
//
//  Created by Kelvin Batista Machado on 10/11/20.
//

import UIKit

extension UIView {
    
    func fadeIn(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        self.alpha = 0.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
        
    }
    
    func fadeOut() {
        UIView.animate(withDuration: 0.5) {
            self.alpha = 0.0
        }
    }
    
}
