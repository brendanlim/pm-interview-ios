//
//  ViewController.swift
//  Product
//
//  Created by Brendan G. Lim on 6/6/14.
//  Copyright (c) 2014 Brendan Lim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var questionLabel : UILabel
    @IBOutlet var navigationButton : UIButton
    @IBOutlet var navigationView : UIView
    @IBOutlet var categoryLabel : UILabel
    @IBOutlet var contentView : UIView
    @IBOutlet var timeLabel : UILabel
    
    var questions = Questions()
    var dateFormatter = NSDateFormatter()
    var startTime: NSDate?
    var timer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var recognizer = UITapGestureRecognizer(target: self,
            action: "nextQuestion:")
        
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1

        questionLabel.addGestureRecognizer(recognizer)
        newQuestionAndResetTime(firstLaunch: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // ------------------------------------------------------------------------------
    // Shows navigation view
    // ------------------------------------------------------------------------------
    
    @IBAction func showNavigation(sender: AnyObject) {
        UIView.animateWithDuration(kNavAnimationDuration,
            delay: 0,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: {
                if (self.contentView.frame.origin.y == kNavYPositionEnd) {
                    self.contentView.frame.origin.y = kNavYPositionBegin
                } else {
                    self.contentView.frame.origin.y = kNavYPositionEnd
                }
            },
            completion: { finished in
            })
        
    }
    
    
    // ------------------------------------------------------------------------------
    // Changes question category
    // ------------------------------------------------------------------------------

    @IBAction func chooseCategory(sender : NavButton) {
        self.questions.changeCategory(sender.categoryName)
        self.categoryLabel.text = sender.categoryName.capitalizedString
        showNavigation(sender);
        newQuestionAndResetTime();
    }
    
    // ------------------------------------------------------------------------------
    // Picks a new question and resets current time
    // ------------------------------------------------------------------------------

    func newQuestionAndResetTime(firstLaunch: Bool = false) {
        UIView.animateWithDuration(kFadeOutAnimationDuration,
            delay: 0,
            options: .CurveEaseIn,
            animations: {
                self.questionLabel.alpha = 0.0
            }, completion: { finished in
                self.timeLabel.text = kDefaultTime

                UIView.animateWithDuration(kFadeInAnimationDuration,
                    delay: 0,
                    options: .CurveEaseIn,
                    animations: {
                        self.questionLabel.text = self.questions.next()
                        self.questionLabel.alpha = 1.0
                    }, completion: { finished in
                        self.resetTimer();
                    })
            })
    }
    

    // ------------------------------------------------------------------------------
    // Resets the timer
    // ------------------------------------------------------------------------------
    
    func resetTimer() {
        if self.timer != nil {
            self.timer!.invalidate();
        } else {
            self.dateFormatter.dateFormat = kDateFormat
            self.dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        }

        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self,
            selector: "updateTimer:", userInfo: nil, repeats: true);
        
        self.startTime = NSDate()
    }
    
    func updateTimer(sender: NSTimer) {
        var currentDate = NSDate()
        var timeInterval = currentDate.timeIntervalSinceDate(self.startTime)
        var totalTimeInterval = timeInterval
        var timerDate = NSDate(timeIntervalSince1970: totalTimeInterval)
        self.timeLabel.text = dateFormatter.stringFromDate(timerDate)
    }

    @IBAction func nextQuestion(sender: AnyObject) {
        newQuestionAndResetTime()
    }
}

