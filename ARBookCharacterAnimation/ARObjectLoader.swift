//
//  ARObjectLoader.swift
//  ARBookCharacterAnimation
//
//  Created by Christopher Webb-Orenstein on 12/13/17.
//  Copyright © 2017 Christopher Webb. All rights reserved.
//

import Foundation
import ARKit

/**
 Loads multiple `VirtualObject`s on a background queue to be able to display the
 objects quickly once they are needed.
 */

class ARObjectLoader {
    
    private(set) var loadedObjects = [ARObject]()
    
    private(set) var isLoading = false
    
    // MARK: - Loading object
    
    /**
     Loads a `VirtualObject` on a background queue. `loadedHandler` is invoked
     on a background queue once `object` has been loaded.
     */
    
    func loadVirtualObject(_ object: ARObject, loadedHandler: @escaping (ARObject) -> Void) {
        isLoading = true
        loadedObjects.append(object)
        // Load the content asynchronously.
        DispatchQueue.global(qos: .userInitiated).async {
            object.reset()
            object.load()
            self.isLoading = false
            loadedHandler(object)
        }
    }
}


