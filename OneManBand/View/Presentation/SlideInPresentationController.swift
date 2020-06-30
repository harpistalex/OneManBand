//
//  SlideInPresentationController.swift
//  OneManBand
//
//  Created by Alexandra King on 29/06/2020.
//  Copyright © 2020 Alex's Amazing Apps. All rights reserved.
//

import UIKit

class SlideInPresentationController: UIPresentationController {
    
    
    //1
    // MARK: - Properties
    private var direction: PresentationDirection
    
    override var frameOfPresentedViewInContainerView: CGRect {
      //1 You declare a frame and give it the size calculated in size(forChildContentContainer:withParentContainerSize:).
      var frame: CGRect = .zero
      frame.size = size(forChildContentContainer: presentedViewController,
                        withParentContainerSize: containerView!.bounds.size)

      //2 For .right and .bottom directions, you adjust the origin by moving the x origin (.right) and y origin (.bottom) 1/3 of the width or height.
      switch direction {
      case .right:
        frame.origin.x = containerView!.frame.width*(1.0/3.0)
      case .bottom:
        frame.origin.y = containerView!.frame.height*(1.0/3.0)
      default:
        frame.origin = .zero
      }
      return frame
    }
    
    //TODO: remove this eventually, don't want a dimming view:
    private var dimmingView: UIView!

    //2
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, direction: PresentationDirection) {
        self.direction = direction
      //3
        super.init(presentedViewController: presentedViewController,
                 presenting: presentingViewController)
        setupDimmingView()
    }
   
    //TODO: remove bits of this eventually, don't want a dimming view:
    
    //Present:
    override func presentationTransitionWillBegin() {
      guard let dimmingView = dimmingView else {
        return
      }
      // 1
      containerView?.insertSubview(dimmingView, at: 0)

      // 2
      NSLayoutConstraint.activate(
        NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|",
          options: [], metrics: nil, views: ["dimmingView": dimmingView]))
      NSLayoutConstraint.activate(
        NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|",
          options: [], metrics: nil, views: ["dimmingView": dimmingView]))

      //3
      guard let coordinator = presentedViewController.transitionCoordinator else {
        dimmingView.alpha = 1.0
        return
      }

      coordinator.animate(alongsideTransition: { _ in
        self.dimmingView.alpha = 1.0
      })
    }
    
    //Dismiss
    override func dismissalTransitionWillBegin() {
      guard let coordinator = presentedViewController.transitionCoordinator else {
        dimmingView.alpha = 0.0
        return
      }

      coordinator.animate(alongsideTransition: { _ in
        self.dimmingView.alpha = 0.0
      })
    }
    
    //Here you reset the presented view’s frame to fit any changes to the containerView frame.
    override func containerViewWillLayoutSubviews() {
      presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    //This method receives the content container and parent view’s size, and then it calculates the size for the presented content. In this code, you restrict the presented view to 2/3 of the screen by returning 2/3 the width for horizontal and 2/3 the height for vertical presentations.
    override func size(forChildContentContainer container: UIContentContainer,
                       withParentContainerSize parentSize: CGSize) -> CGSize {
      switch direction {
      case .left, .right:
        return CGSize(width: parentSize.width*(2.0/3.0), height: parentSize.height)
      case .bottom, .top:
        return CGSize(width: parentSize.width, height: parentSize.height*(2.0/3.0))
      }
    }
    
}

//TODO: remove this eventually, don't want a dimming view:
// MARK: - Private
private extension SlideInPresentationController {
    
    func setupDimmingView() {
        dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        dimmingView.alpha = 0.0
        
        let recognizer = UITapGestureRecognizer(
          target: self,
          action: #selector(handleTap(recognizer:)))
        dimmingView.addGestureRecognizer(recognizer)
        
    }
    //....but keep this!
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }
    
    
}
    
