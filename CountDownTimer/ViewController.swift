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
            clear()
            myTimer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) {(Timer) -> Void in
                let minutes = Int(self.count / 60)
                let sec = Int(self.count) % 60
                self.minutes.text = String(format: "%02d", minutes)
                self.sec.text = String(format: "%02d", sec)
                self.circle.drawCircle(value: self.count)
                if self.count >= self.max { Timer.invalidate() }
                self.count += 0.001
            }
        }
    }
    
    @IBAction func stop(_ sender: Any) {
        if myTimer.isValid {
            myTimer.invalidate()
        }
    }
    
    @IBAction func reset(_ sender: Any) {
        clear()
    }
    
    private var myTimer = Timer()
    private var count:Double = 0
    private var max:Double = 0.0
    private let dataList = ["1", "3", "15", "30", "45", "60"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        max = Double(dataList[0])! * 60.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        circle.setMinMax(min: 0.0, max: max)
        circle.drawBaseCircle()
    }
    
    private func clear() {
        self.count = 0
        self.minutes.text = "00"
        self.sec.text = "00"
        myTimer.invalidate()
        circle.clear()
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(dataList[row])
        self.max = Double(dataList[row])! * 60.0
        circle.setMinMax(min: 0.0, max: self.max)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = dataList[row]
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }
    
}
