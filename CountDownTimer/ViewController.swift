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
    
    @IBOutlet weak var minutes: UILabel!
    
    @IBOutlet weak var sec: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func start(_ sender: Any) {
        if !myTimer.isValid {
            myTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {(Timer) -> Void in
                let minutes = Int(self.count / 60)
                let sec = Int(self.count) % 60
                self.minutes.text = String(format: "%02d", minutes)
                self.sec.text = String(format: "%02d", sec)
                self.circle.drawCircle(value: self.count)
                if self.count >= self.max { Timer.invalidate() }
                self.count += 1
            }
        }
    }
    
    @IBAction func stop(_ sender: Any) {
        if myTimer.isValid {
            myTimer.invalidate()
        }
    }
    
    @IBAction func reset(_ sender: Any) {
        self.count = 0
        self.minutes.text = "00"
        self.sec.text = "00"
        myTimer.invalidate()
        circle.clear()
    }
    
    private var myTimer = Timer()
    private var count:Double = 0
    private var max:Double = 3 * 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circle.setMinMax(min: 0.0, max: max)
        circle.drawBaseCircle()

    }
}

