//
//  PaladinManager.swift
//  ARBookCharacterAnimation
//
//  Created by Christopher Webb-Orenstein on 12/13/17.
//  Copyright © 2017 Christopher Webb. All rights reserved.
//

import SceneKit

class PaladinManager: NSObject {
    
    var paladinNode: SCNNode!
    
    var scene: SCNScene!
    
    override init() {
        if let paladinScene = SCNScene(named: "art.scnassets/Paladin.scn") {
            scene = paladinScene
        }
        super.init()
    }
    
    convenience init(scene: SCNScene)  {
        self.init()
        self.scene = scene
    }
    
}
