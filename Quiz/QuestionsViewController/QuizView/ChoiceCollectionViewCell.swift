//
//  ChoiceCollectionViewCell.swift
//  Quiz
//
//  Created by Raghavendra Shedole on 18/02/18.
//  Copyright © 2018 Raghavendra Shedole. All rights reserved.
//

import UIKit

class ChoiceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var choiceLabel: UILabel!
    @IBOutlet weak var choiceView: CircleView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static var identifier:String {
        return String(describing:self)
    }
    
    func selectChoice() {
        choiceView.backgroundColor = UIColor.colorWithHex(color: "6f6f6f")
    }
    
    func deSelectChoice() {
        choiceView.backgroundColor = UIColor.colorWithHex(color: "F7F7F7")
    }
}

extension UIColor {
    class func colorWithHex(color:String) -> UIColor {
        var cString:String = color.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.sorted().count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

