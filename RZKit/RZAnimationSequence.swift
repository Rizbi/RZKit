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


class RZAnimationSequence: RZAnimation
{
    private var currentAnimation: Int = 0
    
    private var sequence = [RZAnimation]()
    
    init(sequence: Array <RZAnimation>)
    {
        super.init()
        self.sequence = sequence
    }
    
    override func start()
    {
        if self.animating {
            return
        }
        
        self.animating = true
        
        if let anim = self.nextAnimation()
        {
            anim.completionHandler = self.animationFinished(_:)
            anim.start()
        }
    }
    
    private func animationFinished(anim: Bool)
    {
        if let anim = self.nextAnimation()
        {
            anim.completionHandler = self.animationFinished(_:)
            anim.start()
        }
        else
        {
            self.animating = false
            
            if self.completionHandler != nil {
                self.completionHandler(true)
            }
        }
    }
    
    private func nextAnimation() -> RZAnimation?
    {
        if self.currentAnimation < self.sequence.count
        {
            let current = self.sequence[self.currentAnimation]
            self.currentAnimation += 1;
            
            return current
        }
        
        return nil
    }
}