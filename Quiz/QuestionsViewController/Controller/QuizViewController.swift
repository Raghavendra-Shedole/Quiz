//
//  QuizViewController.swift
//  Quiz
//
//  Created by Raghavendra Shedole on 18/02/18.
//  Copyright © 2018 Raghavendra Shedole. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController, CountDownViewDelegate {
    
    @IBOutlet weak var timerView: CountDownView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var submitButton: UIButton!
    
    var isExamStarted = false
    
    let questionModalView = QuestionModalView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerView.delegate = self
        saveDataOnTerminate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timerView.spentTime = questionModalView.getSpentTime()
        timerView.setTime()
        isExamStarted = timerView.spentTime > 0.0 ? true : false
    }
    
    
    /// Saving data on app getting terminated and resign Active
    func saveDataOnTerminate() {
        NotificationCenter.default.addObserver(self, selector: #selector(suspending), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(suspending), name: NSNotification.Name.UIApplicationWillTerminate, object: nil)
    }
    
    @objc func suspending () {
        if isExamStarted {
            questionModalView.saveData()
            questionModalView.saveSpentTime(time: timerView.spentTime)
        }else {
            questionModalView.clearDataForNext()
        }
    }
    
    func isExamStarted(started: Bool) {
        isExamStarted = started
    }
    
    
    
    /// Submitting the exam
    ///
    /// - Parameter sender: button
    @IBAction func submitButtonAction(_ sender: UIButton) {
        questionModalView.result()
        sender.isEnabled = false
        timerView.submit()
        self.performSegue(withIdentifier: String(describing:ResultViewController.self), sender: nil)
    }
    
    
    /// Moving to result view
    ///
    /// - Parameters:
    ///   - segue: show segue with identifier String(describing:ResultViewController.self)
    ///   - sender: nil
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultViewController = segue.destination as! ResultViewController
        resultViewController.noOfCorrectAns = questionModalView.numberOfCorrectAnswers
        resultViewController.noOfWrongAns = questionModalView.numberOfWrongAnswers
        resultViewController.noOfNotAns = questionModalView.numberOfUnswered
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK: - Collection view datasource and delegate
extension QuizViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return questionModalView.arrayOfQuestions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionModalView.arrayOfQuestions[section].choices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChoiceCollectionViewCell.identifier, for: indexPath) as! ChoiceCollectionViewCell
        cell.choiceLabel.text = questionModalView.arrayOfQuestions[indexPath.section].choices[indexPath.row]
        
        // checking the index of answer for selecting the cell
        if indexPath.row == questionModalView.choosedAnswers[indexPath.section] - 1 {
            cell.selectChoice()
        }else {
            cell.deSelectChoice()
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: QuestionHeaderView.identifier, for: indexPath) as! QuestionHeaderView
            header.questionLabel.text = questionModalView.arrayOfQuestions[indexPath.section].question
            return header
        }else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: QuestionFooterView.identifier, for: indexPath) as! QuestionFooterView
            return footer
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if questionModalView.choosedAnswers[indexPath.section] == 0 && isExamStarted {
            let cell = collectionView.cellForItem(at: indexPath) as! ChoiceCollectionViewCell
            //storing the index of answer
            questionModalView.choosedAnswers.insert(indexPath.row + 1, at: indexPath.section)
            cell.selectChoice()
        }
    }   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width:Int = Int(collectionView.frame.width)
        //        let height:Int = Int(collectionView.frame.height)
        
        return  CGSize(width: width - 14, height:30)
    }
}


// MARK: - Setting cell spacing
extension QuizViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(7, 5, 7, 5)
    }
}

