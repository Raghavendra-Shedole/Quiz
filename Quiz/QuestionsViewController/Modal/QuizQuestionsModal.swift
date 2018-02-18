//
//  QuizQuestionsModal.swift
//  Quiz
//
//  Created by Raghavendra Shedole on 18/02/18.
//  Copyright © 2018 Raghavendra Shedole. All rights reserved.
//

import Foundation


class QuestionModalView {
    
    var arrayOfQuestions = [Question]()
    var choosedAnswers = [Int]()
    
    var numberOfCorrectAnswers = 0
    var numberOfWrongAnswers = 0
    var numberOfUnswered = 10
    
    init() {
        
        
        choosedAnswers = getSavedDate()
        
        var question1 = Question.init()
        question1.question = "1.______ comes just before 413."
        question1.choices = ["403","412","410","414"]
        
        var question2 = Question.init()
        question2.question = "2.In 289, the place value of 8 is____________."
        question2.choices = ["Ones","Hundreds","Tens","Thousands"]
        
        var question3 = Question.init()
        question3.question = "3.Three hundred and one can be written as ______."
        question3.choices = ["31","310","301","3001"]
        
        var question4 = Question.init()
        question4.question = "4.232, 242, ____ , 262. The missing number in the pattern is ____."
        question4.choices = ["222","225","252","243"]
        
        var question5 = Question.init()
        question5.question = "5.10+43+34"
        question5.choices = ["87","77","104334","197"]
        
        var question6 = Question.init()
        question6.question = "6.There are 3 sweets in one packet. How many sweets will be there in 9 packets?"
        question6.choices = ["12","27","9","3"]
        
        var question7 = Question.init()
        question7.question = "7.____ is 200 more than 546."
        question7.choices = ["346","446","646","746"]
        
        var question8 = Question.init()
        question8.question = "8.There are 4 apples in each basket. How many apples will be there in 5 baskets?"
        question8.choices = ["5","20","9","10"]
        
        var question9 = Question.init()
        question9.question = "9.Jane bought 60 cherries. She put 6 cherries in each packet. How many packets did she use?"
        question9.choices = ["10","6","5","12"]
        
        var question10 = Question.init()
        question10.question = "10.Which one of the following is correct?"
        question10.choices = ["4+2 = 6","4*2 = 6","2*6 = 8","6+2 = 12"]
        
        arrayOfQuestions = [question1,question2,question3,question4,question5,question6,question7,question8,question9,question10]
    }
    
    /// check the result using this
    func result() {
        let arrayOfAnswers = ["412","Tens","301","252","87","27","746","20","10","4+2 = 6"]
       
        for index in 0...arrayOfQuestions.count-1 {
            
            if choosedAnswers[index] != 0 {
                if arrayOfAnswers[index] == arrayOfQuestions[index].choices[choosedAnswers[index]-1] {
                    numberOfCorrectAnswers += 1
                }else {
                    numberOfWrongAnswers += 1
                }
            }
            numberOfUnswered = 10 - numberOfWrongAnswers - numberOfCorrectAnswers
        }
    }
    
    /// storing time spent by student while solving the quiz
    ///
    /// - Parameter time: time spent
    func saveSpentTime(time:Double) {
       UserDefaults.standard.set(time, forKey: "spentTime")
    }
    
    
    ///  get the time spent by student
    ///
    /// - Returns: time
    func getSpentTime() -> Double {
        
        if let timeSpent = UserDefaults.standard.object(forKey: "spentTime") as? Double {
            return timeSpent
        }
       return 0.0
    }
    
    /// Saving students answers in userdefaults as the data is small(not using core data)
    func saveData() {
         UserDefaults.standard.set(choosedAnswers, forKey: "choosedAnswers")
    }
    
    func getSavedDate() -> [Int] {
        if let savedArray = UserDefaults.standard.object(forKey: "choosedAnswers") as? [Int] {
            return savedArray
        }
        return [Int](repeating: 0, count: 10)
    }
    
    /// On submitting the exam clear the stored data
    func clearDataForNext() {
        UserDefaults.standard.removeObject(forKey: "choosedAnswers")
        UserDefaults.standard.removeObject(forKey: "spentTime")
    }
    
    
}


struct Question:Equatable {
    static func ==(lhs: Question, rhs: Question) -> Bool {
        return lhs.question.lowercased() != rhs.question.lowercased()
    }
    
    var question = ""
    var choices = [String]()
    
    
}
