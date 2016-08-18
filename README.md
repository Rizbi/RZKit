# RZKit subclasses some UIKit classes for easier customization in the storyboard
  - Corner and border can be added in the storyboard.
  - Inset can be added to UILabel in the storyboard.

# Animation of UIView is much easier.
  - FadeIn & FadeOut animation support.
  - ZoomIn & ZoomOut animation support.

# Classes:
RZView, RZLabel, RZTextField, RZTextView, RZAnimation, RZAnimationFade, RZAnimationScale, RZAnimationSequence.

# Animation example in swift

        if let _label = self.label
        {
            let fadeOut = RZAnimationFade(view: _label, duration: 0.25, to: 0.25)
            let fadeIn = RZAnimationFade(view: _label, duration: 0.25, to: 1.0)
            
            let seq = RZAnimationSequence(sequence: [fadeOut, fadeIn])
            seq.completionHandler = self.fadeFinished(_:)
            seq.start()
        }

# Note: Development will be continued.
