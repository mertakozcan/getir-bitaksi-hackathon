//
//  ViewController.swift
//  Hackathon
//
//  Created by Mert Aközcan on 08/03/2017.
//  Copyright © 2017 Mert Aközcan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var request = Request()

    @IBOutlet weak var figureView: FigureView! {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        request.processRequest()
        figureView.figures = request.figures
    }

}
