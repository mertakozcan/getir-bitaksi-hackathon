//
//  FigureView.swift
//  Hackathon
//
//  Created by Mert Aközcan on 10/03/2017.
//  Copyright © 2017 Mert Aközcan. All rights reserved.
//

import UIKit

class FigureView: UIView {
    
    var figures: [Request.Figure]?
    
    private func drawCircle(xPosition: Int, yPosition: Int, r: Int) -> UIBezierPath {
        return UIBezierPath(arcCenter: CGPoint(x: xPosition, y: yPosition), radius: CGFloat(r), startAngle: 0.0, endAngle: CGFloat(2 * M_PI), clockwise: false)
    }
    
    private func drawRectangle(xPosition: Int, yPosition: Int, width: Int, height: Int) -> UIBezierPath {
        return UIBezierPath(rect: CGRect(x: xPosition, y: yPosition, width: width, height: height))
    }
    
    override func draw(_ rect: CGRect) {
        if let array = figures {
            for figure in array {
                switch figure {
                case let .Circle(xPosition, yPosition, r, color):
                    hexStringToUIColor(hex: color).set()
                    drawCircle(xPosition: xPosition, yPosition: yPosition, r: r).fill()
                case let .Rectangle(xPosition, yPosition, width, height, color):
                    hexStringToUIColor(hex: color).set()
                    drawRectangle(xPosition: xPosition, yPosition: yPosition, width: width, height: height).fill()
                }
            }
        }
    }
    
    private func hexStringToUIColor(hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if (cString.characters.count) != 6 {
            return UIColor.gray
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}
