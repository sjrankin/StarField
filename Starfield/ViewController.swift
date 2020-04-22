//
//  ViewController.swift
//  Starfield
//
//  Created by Stuart Rankin on 4/22/20.
//  Copyright © 2020 Stuart Rankin. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        StarFieldViewer.layer.borderColor = UIColor.systemYellow.cgColor
        StarFieldViewer.layer.borderWidth = 4.0
        StarFieldViewer.layer.cornerRadius = 10.0
    }

    @IBOutlet weak var StarFieldViewer: Starfield!
}

