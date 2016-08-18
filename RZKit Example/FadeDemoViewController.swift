//
//  FadeDemoViewController.swift
//  RZKit Example
//
//  Created by Rizbi on 8/18/16.
//  Copyright © 2016 rzkit. All rights reserved.
//

import UIKit

class FadeDemoViewController: UIViewController
{
    @IBOutlet var rzView: RZView?
    @IBOutlet var rzTextField: RZTextField?
    @IBOutlet var rzTextView: RZTextView?
    @IBOutlet var rzLabel: RZLabel?
    
    @IBOutlet var rzButtonFadeIn: RZButton?
    @IBOutlet var rzButtonFadeOut: RZButton?
    @IBOutlet var rzButtonSequence: RZButton?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Fade"
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction
    private func startFadeOutAnimation(sender: RZButton)
    {
        if let _view = self.rzView
        {
            self.enableAllButtons(false)
            
            let fadeOut = RZAnimationFade(view: _view, duration: 1.0, to: 0.1)
            fadeOut.completionHandler = self.animationFinished(_:)
            fadeOut.start()
        }
    }
    
    @IBAction
    private func startFadeInAnimation(sender: RZButton)
    {
        if let _view = self.rzView
        {
            self.enableAllButtons(false)
            
            let fadeOut = RZAnimationFade(view: _view, duration: 1.0, to: 1.0)
            fadeOut.completionHandler = self.animationFinished(_:)
            fadeOut.start()
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
            
            let fadeOut1 = RZAnimationFade(view: _view, duration: 0.5, to: 0.1)
            let fadeIn1 = RZAnimationFade(view: _view, duration: 0.5, to: 1.0)
            let fadeOut2 = RZAnimationFade(view: _view, duration: 0.5, to: 0.1)
            let fadeIn2 = RZAnimationFade(view: _view, duration: 0.5, to: 1.0)
            
            let seq = RZAnimationSequence(sequence: [fadeOut1, fadeIn1, fadeOut2, fadeIn2])
            seq.completionHandler = self.animationFinished(_:)
            seq.start()
        }
    }
    
    private func animationFinished(success: Bool)
    {
        self.enableAllButtons(true)
    }
    
    private func enableAllButtons(enabled: Bool)
    {
        self.rzButtonFadeIn?.enabled = enabled
        self.rzButtonFadeOut?.enabled = enabled
        self.rzButtonSequence?.enabled = enabled
    }
}

