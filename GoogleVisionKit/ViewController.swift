//
//  ViewController.swift
//  GoogleVisionKit
//
//  Created by mnfro on 05/2020.
//  Copyright © 2020 Manfredi Schiera (@mnfro). All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Load an image from the bundle
        let url = Bundle.main.url(forResource: "SAMPLE_IMAGE_GOES_HERE", withExtension: "png")!
        let image = NSImage(contentsOf: url)
        
        // Start the client and pass the image
        let visionClient = VisionClient()
        visionClient.getVisionData((image?.base64String)!) { data in
            
            // Parse the data
            self.parsing(data!)

        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func parsing(_ data: Data) {
        do {
            let visionKit = try JSONDecoder().decode(VisionKit.self, from: data)
            
            let obj = (visionKit.responses?[0].parseText)!
            print(obj)
            
        } catch {
            print(error.localizedDescription)
        }
        
    }


}

