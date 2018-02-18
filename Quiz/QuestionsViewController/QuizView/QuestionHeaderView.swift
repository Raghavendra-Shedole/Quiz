//
//  QuestionHeaderView.swift
//  Quiz
//
//  Created by Raghavendra Shedole on 18/02/18.
//  Copyright © 2018 Raghavendra Shedole. All rights reserved.
//

import UIKit

class QuestionHeaderView: UICollectionReusableView {
   
    @IBOutlet weak var questionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static var identifier:String {
        return String(describing:self)
    }
}
