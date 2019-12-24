//
//  CircleView.swift
//  CountDownTimer
//
//  Created by George Tada on 2019/12/24.
//  Copyright © 2019 George Tada. All rights reserved.
//

import UIKit

class CircleView: UIView {
    let caShapeLayerForBase:CAShapeLayer = CAShapeLayer.init()
    let caShapeLayerForValue:CAShapeLayer = CAShapeLayer.init()
    let outerLineWidth:CGFloat = 1
    let innerLineWidth:CGFloat = 16
    var outerRadius:CGFloat = 0
    var innerRadius:CGFloat = 0
    var minMax:Double = 0
    var preRate:Double = 0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        outerRadius = (self.frame.width - outerLineWidth) / 2.0
        innerRadius = (self.frame.width - outerLineWidth - innerLineWidth) / 2.0
    }
    
    func setMinMax(min: Double, max: Double) {
        self.minMax = max - min
    }
      
    func drawCircle(value:Double) {
        drawBaseCircle()
        let rate = value / minMax * 100
        drawValueCircle(rate: rate)
        preRate = rate
    }
    
    func drawBaseCircle() {
         let shapeFrame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
         caShapeLayerForBase.frame = shapeFrame
         caShapeLayerForBase.strokeColor = rgbColor(r: 0.6, g: 0.6, b: 0.6)
         caShapeLayerForBase.fillColor = UIColor.clear.cgColor
         caShapeLayerForBase.lineWidth = 1
         caShapeLayerForBase.lineCap = .round
         
         let startAngle:CGFloat = CGFloat(0.0)
         let endAngle:CGFloat = CGFloat(Double.pi * 2.0)
         
         caShapeLayerForBase.path = UIBezierPath.init(arcCenter: CGPoint.init(x: shapeFrame.size.width / 2.0,
                                                                              y: shapeFrame.size.height / 2.0),
                                                      radius: outerRadius,
                                                      startAngle: startAngle,
                                                      endAngle: endAngle,
                                                      clockwise: true).cgPath
         self.layer.addSublayer(caShapeLayerForBase)
     }
     
     private func drawValueCircle(rate:Double) {
         let shapeFrame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
         caShapeLayerForValue.frame = shapeFrame
         
         caShapeLayerForValue.strokeColor = rgbColor(r: 0.87, g: 0.3, b: 0.73)
         caShapeLayerForValue.fillColor = UIColor.clear.cgColor
         caShapeLayerForValue.lineWidth = 16
         caShapeLayerForValue.lineCap = .round
         
         let startAngle:CGFloat = CGFloat(-1 * Double.pi / 2.0)
         let endAngle :CGFloat = CGFloat(rate / 100 * Double.pi * 2.0 - (Double.pi / 2.0))
         
         caShapeLayerForValue.path = UIBezierPath.init(arcCenter: CGPoint.init(x: shapeFrame.size.width / 2.0,
                                                                               y: shapeFrame.size.height / 2.0),
                                                       radius: innerRadius,
                                                       startAngle: startAngle,
                                                       endAngle: endAngle,
                                                       clockwise: true).cgPath
         self.layer.addSublayer(caShapeLayerForValue)
     }
     
     private func rgbColor(r: CGFloat, g: CGFloat, b: CGFloat, alpha a:CGFloat = 1.0) -> CGColor {
         return UIColor(displayP3Red: r, green: g, blue: b, alpha: a).cgColor
     }
    
}
