//
//  Starfield.swift
//  Starfield
//
//  Created by Stuart Rankin on 4/22/20.
//  Copyright © 2020 Stuart Rankin. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics
import CoreImage
import SceneKit

class Starfield: SCNView
{
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        Initialize()
    }
    
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        Initialize()
    }
    
    func Initialize()
    {
        self.scene = SCNScene()
        self.showsStatistics = true
        self.antialiasingMode = .none
        
        let Camera = SCNCamera()
        Camera.fieldOfView = 60.0
        Camera.zFar = 1000
        Camera.zNear = 0
        CameraNode = SCNNode()
        CameraNode?.camera = Camera
        CameraNode?.position = SCNVector3(0.0, 0.0, 0.0)
        self.scene?.rootNode.addChildNode(CameraNode!)
        
        let Light = SCNLight()
        Light.type = .ambient
        Light.color = UIColor.white
        LightNode = SCNNode()
        LightNode?.light = Light
        LightNode?.position = SCNVector3(0.0, 0.0, 0.0)
        self.scene?.rootNode.addChildNode(LightNode!)
        
        self.backgroundColor = UIColor.black
        self.autoenablesDefaultLighting = false
        
        FillStars(To: 1000)
    }
    
    var CameraNode: SCNNode? = nil
    var LightNode: SCNNode? = nil
    
    func FillStars(To Count: Int)
    {
        for _ in 0 ..< Count
        {
            MakeStar(StarColor: UIColor.white, SpeedMultiplier: 1.0,
                     MaxStarSize: 0.1)
        }
    }
    
    func MakeStar(StarColor: UIColor, SpeedMultiplier: Double = 1.0, MaxStarSize: Double = 0.15)
    {
        if SpeedMultiplier == 0.0
        {
            fatalError("SpeedMultipler may not be 0.0.")
        }
        let P = PointInSphere(Radius: 100.0)
        let StarSize = Double.random(in: 0.025 ... MaxStarSize)
        let Node = SCNNode(geometry: SCNSphere(radius: CGFloat(StarSize)))
        Node.position = P
//        Node.geometry?.firstMaterial?.diffuse.contents = StarColor
        Node.geometry?.firstMaterial?.diffuse.contents = RandomStarColor()
        Node.geometry?.firstMaterial?.emission.contents = UIColor.yellow
        self.scene?.rootNode.addChildNode(Node)
        let ZGone = 1.0
        let Destination = SCNVector3(P.x, P.y, Float(ZGone))
        let Duration = (ZGone - Double(P.z)) / SpeedMultiplier
        let Motion = SCNAction.move(to: Destination, duration: Duration)
        Node.opacity = 0.0
        let FadeIn = SCNAction.fadeIn(duration: 1.0)
        let Group = SCNAction.group([FadeIn, Motion])
        Node.runAction(Group)
        {
            Node.removeAllActions()
            Node.removeFromParentNode()
            self.MakeStar(StarColor: UIColor.white, SpeedMultiplier: 1.0, MaxStarSize: 0.1)
        }
    }
    
    func RandomStarColor() -> UIColor
    {
        let Percent = Double.random(in: 0.0 ... 1.0)
        for (StarPercent, Color) in StarColors
        {
            if Percent <= StarPercent
            {
                return Color
            }
        }
        return UIColor.white
    }
    
    let StarColors: [(Double, UIColor)] =
    [
        (0.7645, UIColor(red: 1.0, green: 202 / 255, blue: 122 / 255, alpha: 1.0)),
        (0.8855, UIColor(red: 1.0, green: 209 / 255, blue: 166 / 255, alpha: 1.0)),
        (0.9615, UIColor(red: 1.0, green: 244 / 255, blue: 235 / 255, alpha: 1.0)),
        (0.9915, UIColor(red: 248 / 255, green: 247 / 255, blue: 1.0, alpha: 1.0)),
        (0.9975, UIColor(red: 202 / 255, green: 217 / 255, blue: 253 / 255, alpha: 1.0)),
        (0.9988, UIColor(red: 169 / 255, green: 194 / 255, blue: 252 / 255, alpha: 1.0)),
    ]
    
    //http://datagenetics.com/blog/january32020/index.html
    func PointInSphere(Radius: Double) -> SCNVector3
    {
        while true
        {
            let X = Double.random(in: -1.0 ... 1.0)
            let Y = Double.random(in: -1.0 ... 1.0)
            let Z = Double.random(in: -1.0 ... 0.0)
            if sqrt((X * X) + (Y * Y) + (Z * Z)) < 1.0
            {
                return SCNVector3(X * Radius, Y * Radius, Z * Radius)
            }
        }
    }
}
