//
//  Fade.swift
//  Must-See
//
//  Created by Kelvin Batista Machado on 10/11/20.
//

import UIKit

extension UIView {
    
    func fadeIn() {
        self.alpha = 0.0
        
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1.0
        }
    }
    
    func fadeOut() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0.0
        }
    }
    
}
