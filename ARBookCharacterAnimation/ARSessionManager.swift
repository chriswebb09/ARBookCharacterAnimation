//
//  ARSessionManager.swift
//  ARBookCharacterAnimation
//
//  Created by Christopher Webb-Orenstein on 12/13/17.
//  Copyright © 2017 Christopher Webb. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ARSessionManager: NSObject {
    
    /// A serial queue used to coordinate adding or removing nodes from the scene.
    
    let updateQueue = DispatchQueue(label: "com.serial")
    
    /// Coordinates the loading and unloading of reference nodes for virtual objects.
    
    let virtualObjectLoader = ARObjectLoader()
    
    var objects: [ARObject] = []
    
    weak var delegate: ARSessionManagerDelegate?
    
    override init() {
        super.init()
    }
}

extension ARSessionManager: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        DispatchQueue.main.async {
            if let planeAnchor = anchor as? ARPlaneAnchor {
                let newNode = PlaneGenerator.getPlane(from: planeAnchor)
                node.addChildNode(newNode)
                let arObject = ARObject(url: URL(fileURLWithPath: "/art.scnassets/Paladin.scn"))
                arObject?.adjustOntoPlaneAnchor(planeAnchor, using: node)
                self.delegate?.planeNode(is: true, planeAnchor: planeAnchor)
            }
        }
    }
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        updateQueue.async {
            for object in self.objects {
                 object.adjustOntoPlaneAnchor(planeAnchor, using: node)
            }
        }
    }
}

extension ARSessionManager: ARSessionDelegate {
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        switch camera.trackingState {
        case .notAvailable:
            delegate?.update(current: "Tracking unavailable")
        case .normal:
            delegate?.update(current: "Tracking normal")
        case .limited(.excessiveMotion):
            delegate?.update(current: "Tracking limited - Too much camera movement")
        case .limited(.insufficientFeatures):
            delegate?.update(current: "Tracking limited - Not enough surface detail")
        case .limited(.initializing):
            delegate?.update(current: "Tracking limited - Too much camera movement")
        }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        print("did fail \(error.localizedDescription)")
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        print("interrupted")
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        print("interruption ended")
    }
}

