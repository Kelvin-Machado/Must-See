//
//  GradientView.swift
//  Must-See
//
//  Created by Kelvin Batista Machado on 23/11/20.
//

import UIKit

class GradientView: UIView {


    var colors:[UIColor] = [UIColor.purple, UIColor.darkGray]

    override func draw(_ rect: CGRect) {
        setGradient(color1: colors[0], color2: colors[1])
    }

    func setGradient(color1: UIColor, color2: UIColor) {

        let context = UIGraphicsGetCurrentContext()
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [color1.cgColor, color2.cgColor] as CFArray, locations: [0, 1])!

        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        context!.saveGState()
        path.addClip()
        context!.drawLinearGradient(gradient, start: CGPoint(x: frame.width / 2, y: 0), end: CGPoint(x: frame.width / 2, y: frame.height), options: CGGradientDrawingOptions())
        context!.restoreGState()
        
    }

    override func layoutSubviews() {
        backgroundColor = UIColor.clear
    }

}
