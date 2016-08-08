//
//  SwipeDismissAnimationController.m
//  Cordova Samples
//
//  Created by Claire Young on 8/5/16.
//
//

#import "SwipeDismissAnimationController.h"

@interface SwipeDismissAnimationController () <UIViewControllerAnimatedTransitioning>
@end

@implementation SwipeDismissAnimationController

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 2;
}

+(CATransform3D)yRotation:(double)angle {
    return CATransform3DMakeRotation((CGFloat)angle, 0.0, 1.0, 0.0);
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView* containerView = [transitionContext containerView];
    
    CGRect finalFrame = CGRectMake(self.destinationFrame.origin.x,
                                   self.destinationFrame.origin.y - self.destinationFrame.size.height,
                                   self.destinationFrame.size.width,
                                   self.destinationFrame.size.height);
    
    UIView* snapshot = [fromVC.view snapshotViewAfterScreenUpdates:false];
    UIView* finishingSnapshot = [toVC.view snapshotViewAfterScreenUpdates:true];
    finishingSnapshot.frame = CGRectMake(self.destinationFrame.origin.x,
                                         self.destinationFrame.origin.y + self.destinationFrame.size.height,
                                         self.destinationFrame.size.width,
                                         self.destinationFrame.size.height);
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:finishingSnapshot];
    [containerView addSubview:snapshot];
    
    fromVC.view.hidden = true;


    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0 options:
    UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1.0 animations:^(void){
            snapshot.frame = finalFrame;
            finishingSnapshot.frame = self.destinationFrame;
        }];
    } completion:^(BOOL finished){
        fromVC.view.hidden = false;
        [snapshot removeFromSuperview];
        [finishingSnapshot removeFromSuperview];
        [transitionContext completeTransition:true];
    }];
}

@end
