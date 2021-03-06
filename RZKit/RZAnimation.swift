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


class RZAnimation
{
    private var animating: Bool = false
    
    var view = UIView()
    
    var duration: NSTimeInterval = 0.0
    var completionHandler:((RZAnimation)->Void)!
    
    init(view: UIView = UIView(), duration: NSTimeInterval = 0.0)
    {
        self.view = view
        self.duration = duration
    }
    
    // start doesnot call end except subclasses
    
    func start()
    {
        if self.animating
        {
            return
        }
        
        self.animating = true
    }
    
    // this function should be called manually or from subclasses
    
    final func end()
    {
        if self.animating
        {
            self.view.layer.removeAllAnimations()
            
            self.animating = false
            
            if (self.completionHandler != nil)
            {
                self.completionHandler(self)
            }
        }
    }
    
    func isAnimating() -> Bool
    {
        return self.animating
    }
}