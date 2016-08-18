//
//  ScaleDemoViewController.swift
//  RZKit Example
//
//  Created by Rizbi on 8/18/16.
//  Copyright © 2016 rzkit. All rights reserved.
//

import UIKit

class ScaleDemoViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet var rzView: RZView?
    @IBOutlet var durationField: RZTextField?
    
    @IBOutlet var rzButtonScaleUp: RZButton?
    @IBOutlet var rzButtonScaleDown: RZButton?
    @IBOutlet var rzButtonSequence: RZButton?
    
    var anchor: RZAnimationScaleAnchor = RZAnimationScaleAnchor.Default
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Anchor (Center)"
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction
    private func startScaleUpAnimation(sender: RZButton)
    {
        if let _view = self.rzView
        {
            self.enableAllButtons(false)
            
            let scaleUp = RZAnimationScale(view: _view, duration: self.getAnimationDuration(), percent: 400.0, anchor: self.anchor)
            scaleUp.completionHandler = self.animationFinished(_:)
            scaleUp.start()
        }
    }
    
    @IBAction
    private func startScaleDownAnimation(sender: RZButton)
    {
        if let _view = self.rzView
        {
            self.enableAllButtons(false)
            
            let scaleDown = RZAnimationScale(view: _view, duration: self.getAnimationDuration(), percent: 25.0, anchor: self.anchor)
            scaleDown.completionHandler = self.animationFinished(_:)
            scaleDown.start()
        }
    }
    
    @IBAction
    private func startSequenceAnimation(sender: RZButton)
    {
        if let _view = self.rzView
        {
            // keep buttons disbled while an animation is in effect
            // Not mandatory!
            self.enableAllButtons(false)
            
            let scaleDown1 = RZAnimationScale(view: _view, duration: self.getAnimationDuration(), percent: 25.0, anchor: self.anchor)
            let scaleUp1 = RZAnimationScale(view: _view, duration: self.getAnimationDuration(), percent: 400.0, anchor: self.anchor)
            
            let delay = RZAnimationDelay(delay: 0.25)
            
            let scaleDown2 = RZAnimationScale(view: _view, duration: self.getAnimationDuration(), percent: 25.0, anchor: self.anchor)
            let scaleUp2 = RZAnimationScale(view: _view, duration: self.getAnimationDuration(), percent: 400.0, anchor: self.anchor)
            
            let seq = RZAnimationSequence(sequence: [scaleDown1, scaleUp1, delay, scaleDown2, scaleUp2])
            seq.completionHandler = self.animationFinished(_:)
            seq.start()
        }
    }
    
    private func animationFinished(anim: RZAnimation)
    {
        self.enableAllButtons(true)
    }
    
    private func enableAllButtons(enabled: Bool)
    {
        self.rzButtonScaleUp?.enabled = enabled
        self.rzButtonScaleDown?.enabled = enabled
        self.rzButtonSequence?.enabled = enabled
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        self.durationField?.text = "\(self.getAnimationDuration())"
        
        textField.resignFirstResponder()
        
        return true
    }
    
    private func getAnimationDuration() -> NSTimeInterval
    {
        var duration: NSTimeInterval = 0.5
        
        if let _textField = self.durationField, let _text = _textField.text
        {
            duration =  NSTimeInterval((_text as NSString).doubleValue)
        }
        
        if duration < 0.1
        {
            duration = 0.1
        }
        
        return duration
    }
    
    @IBAction
    private func setAnchor(sender: RZButton)
    {
        let alertController = UIAlertController(title: "Choose Anchor Point", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let x = UIAlertAction(title: "Default/Center", style: UIAlertActionStyle.Default) { (action:UIAlertAction) in
            self.anchor = RZAnimationScaleAnchor.Center
            self.title = "Anchor (Center)"
        }
        alertController.addAction(x)
        
        let a = UIAlertAction(title: "Left Top", style: UIAlertActionStyle.Default) { (action:UIAlertAction) in
            self.anchor = RZAnimationScaleAnchor.LeftTop
            self.title = "Anchor (Left Top)"
            }
        alertController.addAction(a)
        
        let b = UIAlertAction(title: "Left Bottom", style: UIAlertActionStyle.Default) { (action:UIAlertAction) in
            self.anchor = RZAnimationScaleAnchor.LeftBottom
            self.title = "Anchor (Left Bottom)"
        }
        alertController.addAction(b)
        
        let c = UIAlertAction(title: "Right Top", style: UIAlertActionStyle.Default) { (action:UIAlertAction) in
            self.anchor = RZAnimationScaleAnchor.RightTop
            self.title = "Anchor (Right Top)"
        }
        alertController.addAction(c)
        
        let d = UIAlertAction(title: "Right Bottom", style: UIAlertActionStyle.Default) { (action:UIAlertAction) in
            self.anchor = RZAnimationScaleAnchor.RightBottom
            self.title = "Anchor (Right Bottom)"
        }
        alertController.addAction(d)
        
        let z = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        alertController.addAction(z)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
