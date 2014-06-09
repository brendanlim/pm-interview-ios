//
//  Questions.swift
//  Product
//
//  Created by Brendan G. Lim on 6/7/14.
//  Copyright (c) 2014 Brendan Lim. All rights reserved.
//

import Foundation

class Questions {
    
    var questionPool = Array<String>()
    var questionsAsked = Int[]()
    var currentCategory = kCategoryAll
    let questions : Dictionary<String, String[]>

    init() {
        self.questions = NSDictionary(contentsOfFile:
            NSBundle.mainBundle().pathForResource("Questions", ofType: "plist"))["questions"]
            as Dictionary<String, String[]>
        
        changeCategory(kCategoryAll)
    }
    
    func changeCategory(newCategory: String) {
        self.currentCategory = newCategory
        
        switch (currentCategory) {
        case kCategoryBehavioral:
            self.questionPool = self.questions[kCategoryBehavioral]!
            
        case kCategoryDesign:
            self.questionPool = self.questions[kCategoryDesign]!
            
        case kCategoryEstimation:
            self.questionPool = self.questions[kCategoryEstimation]!
            
        default:
            self.questionPool = self.questions[kCategoryBehavioral]!
            self.questionPool += self.questions[kCategoryDesign]!
            self.questionPool += self.questions[kCategoryEstimation]!
        }
        
        self.questionsAsked = []
    }
    
    func next() -> String {
        var index = 0
        if countElements(questionsAsked) > 0 {
            index = findNextQuestionIndex()
        }
        
        self.questionsAsked.append(index)
        
        return self.questionPool[index]
    }
    
    func findNextQuestionIndex() -> Int {
        var index = 0
        
        if countElements(questionsAsked) == self.questionPool.count {
            questionsAsked = [0]
        } else {
            while (contains(questionsAsked, index)) {
                index = Int(arc4random_uniform(UInt32(self.questionPool.count)))
            }
        }
        
        return index
    }
}