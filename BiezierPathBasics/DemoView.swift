//
//  DemoView.swift
//  BiezierPathBasics
//
//  Created by Rajat on 2/15/18.
//  Copyright © 2018 None. All rights reserved.
//

import UIKit

class DemoView: UIView {
    var path: UIBezierPath!
    
//    override func draw(_ rect: CGRect) {
//        self.createRectangle()
//        self.createTriangle()
//
//        //Create an oval shape path.
//        self.path = UIBezierPath(ovalIn: self.bounds)
//
//        //Create circle
//        self.path = UIBezierPath(ovalIn: CGRect(x: self.frame.size.width/2 - self.frame.size.height/2,
//                                                y: 0.0,
//                                                width: self.frame.size.height,
//                                                height: self.frame.size.height))
//
//        //rectangle with rounded corners
//        path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 15.0)
//
////        //rectange with just two rounded corners
//        path = UIBezierPath(roundedRect: self.bounds,
//                            byRoundingCorners: [.topLeft, .topRight],
//                            cornerRadii: CGSize(width: 15.0, height: 0.0))
//
////        //create arc
//        path = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width/2, y: 0),
//                            radius: 20,
//                            startAngle: CGFloat(180.0).toRadians(),
//                            endAngle: CGFloat(0.0).toRadians(),
//                            clockwise: false)
//
//        //Add shadow
//        let shadowPath = getPathForShadowOnTopOfView()
//        self.layer.masksToBounds = false
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOpacity = 1
//        self.layer.shadowOffset = CGSize.zero
//        self.layer.shadowRadius = 15
//
//        self.layer.shadowPath = shadowPath.cgPath
////        self.layer.shouldRasterize = true
////        self.layer.rasterizationScale = true ? UIScreen.main.scale : 1
//
//        // Specify the fill color and apply it to the path.
//        UIColor.green.setFill()
//        path.fill()
//
//        // Specify a border (stroke) color.
//        UIColor.clear.setStroke()
//        path.stroke()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.gray
//        simpleShapeLayer()
//        maskVsSublayer()
//        twoShapes()
//        arcOnView()
        createTextLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //Create rectange
    func createRectangle() {
        // Initialize the path.
        path = UIBezierPath()
        
        // Specify the point that the path should start get drawn.
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        
        // Create a line between the starting point and the bottom-left side of the view.
        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
        
        // Create the bottom line (bottom-left to bottom-right).
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        
        // Create the vertical line from the bottom-right to the top-right side.
        path.addLine(to: CGPoint(x: self.frame.size.width, y: 0.0))
        
        // Close the path. This will create the last line automatically.
        path.close()
    }
    
    //Create Triangle
    func createTriangle() {
        path = UIBezierPath()
        path.move(to: CGPoint(x: self.frame.width/2, y: 0.0))
        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        path.close()
    }
    
    //Create simple shape layer
    func simpleShapeLayer() {
        self.createRectangle()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = self.path.cgPath
        
        shapeLayer.fillColor = UIColor.yellow.cgColor
        shapeLayer.strokeColor = UIColor.brown.cgColor
        shapeLayer.lineWidth = 3.0
        
        self.layer.addSublayer(shapeLayer)
    }
    
    //Mask vs Sublayer
    func maskVsSublayer() {
        self.createTriangle()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.yellow.cgColor
        
//        self.layer.addSublayer(shapeLayer)
        self.backgroundColor = UIColor.blue
        self.layer.mask = shapeLayer
    }
    
    //Add two shapes
    func twoShapes() {
        let width: CGFloat = self.frame.size.width/2
        let height: CGFloat = self.frame.size.height/2
        
        let path1 = UIBezierPath()
        path1.move(to: CGPoint(x: width/2, y: 0.0))
        path1.addLine(to: CGPoint(x: 0.0, y: height))
        path1.addLine(to: CGPoint(x: width, y: height))
        path1.close()
        
        let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: width/2, y: height))
        path2.addLine(to: CGPoint(x: 0.0, y: 0.0))
        path2.addLine(to: CGPoint(x: width, y: 0.0))
        path2.close()
        
        let shapeLayer1 = CAShapeLayer()
        shapeLayer1.path = path1.cgPath
        shapeLayer1.fillColor = UIColor.yellow.cgColor
        
        let shapeLayer2 = CAShapeLayer()
        shapeLayer2.path = path2.cgPath
        shapeLayer2.fillColor = UIColor.green.cgColor
        
        self.layer.addSublayer(shapeLayer1)
        self.layer.addSublayer(shapeLayer2)
        shapeLayer2.position = CGPoint(x: 0.0, y: height)
        shapeLayer2.position = CGPoint(x: width/2, y: height)
        shapeLayer1.position = CGPoint(x: width/2, y: 0.0)
        
        shapeLayer1.bounds.origin = CGPoint(x: 0.0, y: 0.0)
        shapeLayer1.bounds.size = CGSize(width: 200.0, height: 150.0)
        shapeLayer1.backgroundColor = UIColor.magenta.cgColor
        shapeLayer1.bounds.origin = CGPoint(x: -20.0, y: -40.0)
    }
    
    func arcOnView() {
        path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width/2, y: -22), radius: 40, startAngle: CGFloat(0).toRadians(), endAngle: CGFloat(180).toRadians(), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func complexShape() {
        path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: self.frame.size.width/2 - 50.0, y: 0.0))
        path.addArc(withCenter: CGPoint(x: self.frame.size.width/2 - 25.0, y: 25.0),
                    radius: 25.0,
                    startAngle: CGFloat(180.0).toRadians(),
                    endAngle: CGFloat(0.0).toRadians(),
                    clockwise: false)
        path.addLine(to: CGPoint(x: self.frame.size.width/2, y: 0.0))
        path.addLine(to: CGPoint(x: self.frame.size.width - 50.0, y: 0.0))
        path.addCurve(to: CGPoint(x: self.frame.size.width, y: 50.0),
                      controlPoint1: CGPoint(x: self.frame.size.width + 50.0, y: 25.0),
                      controlPoint2: CGPoint(x: self.frame.size.width - 150.0, y: 50.0))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
        path.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        
        self.backgroundColor = UIColor.orange
        self.layer.mask = shapeLayer
    }
    
    //add shadow on top of rectangle with corner radius
    func getPathForShadowOnTopOfView() -> UIBezierPath {
        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: 0, y: 15))
        shadowPath.addArc(withCenter: CGPoint(x: 15, y: 15), radius: 15, startAngle: CGFloat(180).toRadians(), endAngle: CGFloat(270).toRadians(), clockwise: true)
        shadowPath.addLine(to: CGPoint(x: self.frame.width-15, y: 0))
        shadowPath.addArc(withCenter: CGPoint(x: self.frame.width-15, y: 15), radius: 15, startAngle: CGFloat(270).toRadians(), endAngle: CGFloat(0).toRadians(), clockwise: true)
        return shadowPath
    }
    
    //Text Layer
    func createTextLayer() {
        let textLayer = CATextLayer()
        textLayer.string = "WOW!\nThis is text on a layer!"
        textLayer.foregroundColor = UIColor.white.cgColor
        textLayer.font = UIFont(name: "Avenir", size: 15.0)
        textLayer.fontSize = 15.0
        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.backgroundColor = UIColor.orange.cgColor
        textLayer.frame = CGRect(x: 0.0, y: self.frame.size.height/2 - 20.0, width: self.frame.size.width, height: 40.0)
        textLayer.contentsScale = UIScreen.main.scale
        self.layer.addSublayer(textLayer)
    }
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}
