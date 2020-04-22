//
//  ViewController.swift
//  Starfield
//
//  Created by Stuart Rankin on 4/22/20.
//  Copyright © 2020 Stuart Rankin. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        StarFieldViewer.FillStars(To: 1000, WithSpeed: 1.0)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        switch pickerView
        {
            case VelocityPicker:
                return VelocityValues.count
            
            default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        switch pickerView
        {
            case VelocityPicker:
            return "\(VelocityValues[row])"
            
            default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
    switch pickerView
    {
        case VelocityPicker:
        StarFieldViewer.ChangeSpeed(To: VelocityValues[row])
        
        default:
        return
        }
    }

    var VelocityValues = [0.0, 0.25, 0.50, 0.75,
                          1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0,
                          20.0, 30.0, 50.0, 100.0]
    

    @IBOutlet weak var VelocityPicker: UIPickerView!
    @IBOutlet weak var StarFieldViewer: Starfield!
}

