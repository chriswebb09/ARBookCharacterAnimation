//
//  PlaneGenerator.swift
//  ARBookCharacterAnimation
//
//  Created by Christopher Webb-Orenstein on 12/13/17.
//  Copyright © 2017 Christopher Webb. All rights reserved.
//

import ARKit
import SceneKit

class PlaneGenerator {
    
    static func getPlane(from anchor: ARPlaneAnchor) -> SCNNode {
        let plane = self.plane(from: anchor)
        let planeNode = SCNNode(geometry: plane)
        planeNode.position = self.position(from: anchor)
        return planeNode
    }
    
    static func position(from anchor: ARPlaneAnchor) -> SCNVector3 {
        let centerX = anchor.center.x
        let centerZ = anchor.center.z
        return SCNVector3Make(centerX, -0.55, centerZ)
    }
    
    static func plane(from anchor: ARPlaneAnchor) -> SCNGeometry {
        let xExtent = CGFloat(anchor.extent.x) + 1.5
        let zExtent = CGFloat(anchor.extent.z) + 2
        let plane = SCNBox(width: xExtent, height: 0.005, length: zExtent, chamferRadius: 0)
        let color = SCNMaterial()
        color.diffuse.contents = UIColor.blue.withAlphaComponent(0.4)
        plane.materials = [color]
        return plane
    }
}
