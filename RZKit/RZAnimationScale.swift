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

enum RZAnimationScaleAnchor: Int
{
    case Default, Center
    case LeftTop
    case LeftBottom
    case RightTop
    case RightBottom
}

class RZAnimationScale: RZAnimation
{
    var percent: CGFloat = 50.0
    var anchor: RZAnimationScaleAnchor = RZAnimationScaleAnchor.Default
    
    init(view: UIView, duration: NSTimeInterval, percent: CGFloat, anchor: RZAnimationScaleAnchor = RZAnimationScaleAnchor.Default)
    {
        super.init(view: view, duration: duration)
        
        self.percent = percent
        self.anchor = anchor
    }
    
    override func start()
    {
        if self.animating {
            return
        }
        
        
        self.animating = true
        
        let frame = self.getNewFrame()
        
        UIView.animateWithDuration(self.duration, animations: {
            self.view.frame = frame
            
        }) { (success) in
            
            self.animating = false
            
            if success
            {
                if self.completionHandler != nil {
                    self.completionHandler(true)
                }
            }
        }
    }
    
    private func getNewFrame() -> CGRect
    {
        let frame = self.view.frame
        let newWidth = ((frame.size.width * self.percent) / 100.0)
        let newHeight = ((frame.size.height * self.percent) / 100.0)
        var newX = frame.origin.x
        var newY = frame.origin.y
        
        switch self.anchor
        {
        case RZAnimationScaleAnchor.LeftTop: break
            
        case RZAnimationScaleAnchor.LeftBottom:
            let y = newHeight - frame.size.height
            newY -= y
            
        case RZAnimationScaleAnchor.RightTop:
            let w = newWidth - frame.size.width
            newX -= w
            
        case RZAnimationScaleAnchor.RightBottom:
            let y = newHeight - frame.size.height
            newY -= y
            let w = newWidth - frame.size.width
            newX -= w
            
        default:
            let y = newHeight - frame.size.height
            newY -= (y/2.0)
            let w = newWidth - frame.size.width
            newX -= (w/2.0)
        }
        
        return CGRectMake(newX, newY, newWidth, newHeight)
    }
}