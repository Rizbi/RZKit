// Copyright (c) 2016 Sultan Rizbi ( https://github.com/Rizbi )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


import UIKit

enum RZAnimationSequenceRepeatOption: Int
{
    case Default = 0
    case Cycle = 1
}

class RZAnimationSequence: RZAnimation
{
    // can be set anytime
    var shouldRepeat: Bool = false
    var repeatOption: RZAnimationSequenceRepeatOption = RZAnimationSequenceRepeatOption.Default
    
    // privatelty used variables
    private var currentAnimationIndex: Int = 0
    private var sequence = [RZAnimation]()
    private var forwarding: Bool = false
    
    init(sequence: Array <RZAnimation>)
    {
        super.init()
        self.sequence = sequence
    }
    
    override func start()
    {
        super.start()
        
        self.forwarding = true
        self.startNextAnimation()
    }
    
    private func animationFinished(anim: RZAnimation)
    {
        if (self.startNextAnimation() == nil)
        {
            if self.shouldRepeat
            {
                if (self.repeatOption == RZAnimationSequenceRepeatOption.Default)
                {
                    self.forwarding = true
                    self.currentAnimationIndex = 0;
                }
                else if (self.forwarding)
                {
                    self.forwarding = false
                    self.currentAnimationIndex = ((self.sequence.count > 1) ? (self.sequence.count - 2) : 0);
                }
                else
                {
                    self.forwarding = true
                    self.currentAnimationIndex = ((self.sequence.count > 1) ? 1 : 0);
                }                
                self.startNextAnimation()
            }
            else
            {
                super.end()
            }
        }
    }
    
    private func startNextAnimation() -> RZAnimation?
    {
        if (self.currentAnimationIndex >= 0 && self.currentAnimationIndex < self.sequence.count)
        {
            let current = self.sequence[self.currentAnimationIndex]
            
            current.completionHandler = self.animationFinished(_:)
            current.start()
            
            if self.forwarding
            {
                self.currentAnimationIndex += 1;
            }
            else
            {
                self.currentAnimationIndex -= 1;
            }
            
            return current
        }
        
        return nil
    }
}