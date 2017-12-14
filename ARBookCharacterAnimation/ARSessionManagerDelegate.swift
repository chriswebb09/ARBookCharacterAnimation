//
//  ARSessionManagerDelegate.swift
//  ARBookCharacterAnimation
//
//  Created by Christopher Webb-Orenstein on 12/13/17.
//  Copyright © 2017 Christopher Webb. All rights reserved.
//

import ARKit
import SceneKit

protocol ARSessionManagerDelegate: class {
    func update(current trackingState: String)
    func planeNode(is inPlace: Bool, planeAnchor: ARPlaneAnchor)
}

