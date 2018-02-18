//
//  CountDownView.swift
//  Quiz
//
//  Created by Raghavendra Shedole on 18/02/18.
//  Copyright © 2018 Raghavendra Shedole. All rights reserved.
//

import UIKit

protocol CountDownViewDelegate {
    func isExamStarted(started:Bool)
    
}

class CountDownView: UIView {
    
    var delegate:CountDownViewDelegate?
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    

    var spentTime = 0.0
    var countDownClock:Timer?
    
    private var formatter:DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute,.second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    @IBAction func startButtonAction(_ sender: UIButton) {
    self.startButton.isSelected = true
    self.startButton.backgroundColor = UIColor.colorWithHex(color: "002D51")
    self.stopButton.backgroundColor = UIColor.white
    self.stopButton.isSelected = false
        let startTime = Date()
        let countTime = Date() + 600 - spentTime // 10 minutes
        
        
        DispatchQueue.main.async {
            if startTime <= countTime {
                self.countDownClock = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self]_ in
                    self?.timeLabel.text = self?.formatter.string(from:Date() , to:  countTime)
                    self?.spentTime += 1.0
                })
            }
        }
        
        if let delegate = delegate {
            delegate.isExamStarted(started: true)
        }
    }
    
    @IBAction func stopButtonAction(_ sender: UIButton) {
        self.startButton.isSelected = false
        self.stopButton.isSelected = true
        self.stopButton.backgroundColor = UIColor.colorWithHex(color: "002D51")
        self.startButton.backgroundColor = UIColor.white
        countDownClock?.invalidate()
        if let delegate = delegate {
            delegate.isExamStarted(started: false)
        }
    }
    
    func submit() {
        stopButtonAction(self.stopButton)
        startButton.isEnabled = false
        stopButton.isEnabled = false
    }
    
    func setTime() {
        self.timeLabel.text = self.formatter.string(from:Date() , to:  Date() + 600 - spentTime)
    }
    
    deinit {
        countDownClock?.invalidate()
        if let delegate = delegate {
            delegate.isExamStarted(started: false)
        }
    }

}
