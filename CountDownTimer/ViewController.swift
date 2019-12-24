//
//  ViewController.swift
//  CountDownTimer
//
//  Created by George Tada on 2019/12/24.
//  Copyright © 2019 George Tada. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var circle: CircleView!
    
    @IBOutlet weak var counter: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func start(_ sender: Any) {
        if !myTimer.isValid {
            myTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {(Timer) -> Void in
                self.counter.text = String(format: "%03.1f", self.count)
                self.circle.drawCircle(value: self.count)
                self.count += 0.1
                if self.count >= self.max { Timer.invalidate() }
            }
        }
    }
    
    @IBAction func stop(_ sender: Any) {
        if myTimer.isValid {
            myTimer.invalidate()
        }
    }
    
    @IBAction func reset(_ sender: Any) {
    }
    
    private var myTimer = Timer()
    private var count:Double = 0
    private var max:Double = 3 * 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circle.setMinMax(min: 0.0, max: max)

    }


}

