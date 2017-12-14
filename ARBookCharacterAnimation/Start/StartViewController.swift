//
//  StartViewController.swift
//  ARBookCharacterAnimation
//
//  Created by Christopher Webb-Orenstein on 12/13/17.
//  Copyright © 2017 Christopher Webb. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

protocol StartViewControllerDelegate: class {
    
}

class StartViewController: UIViewController, Controller {
    var type: ControllerType = .start
    
    @IBOutlet var sceneView: StartSceneView!
    @IBOutlet weak var messageLabel: UILabel!
    
    weak var delegate: StartViewControllerDelegate?
    
    var sessionManager = ARSessionManager()
    let session = ARSession()
    
    let standardConfiguration: ARWorldTrackingConfiguration = {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        configuration.isLightEstimationEnabled = true
        return configuration
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = SCNScene()
        sceneView.scene = scene
        runSession()
        sceneView.setup()
    }
    
    func runSession() {
        sceneView.delegate = sessionManager
        sceneView.session.delegate = sessionManager
        sessionManager.delegate = self
        sceneView.session.run(standardConfiguration)
        #if DEBUG
            sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        #endif
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       // sceneView.moveDrone()
    }
}

extension StartViewController: ARSessionManagerDelegate {
    
    func update(current trackingState: String) {
        messageLabel.text = trackingState
    }
    
    func planeNode(is inPlace: Bool, planeAnchor: ARPlaneAnchor) {
        
        
    }
    
//    func planeNode(is inPlace: Bool, planeAnchor: ARPlaneAnchor) {
//        print(sceneView.session.currentFrame?.lightEstimate)
//        print(sceneView.session.currentFrame?.lightEstimate?.ambientIntensity)
//        let position = SCNVector3(x: planeAnchor.center.x, y: (planeAnchor.center.y - 0.8), z:  planeAnchor.center.z)
//       // self.sceneView.setDroneStart(position: position)
//        self.standardConfiguration.planeDetection = []
//        self.sceneView.session.run(self.standardConfiguration, options: [])
//    }
}

