//
//  AMCollectionViewCell.m
//  DemoCollection
//
//  Created by  as7 on 17/9/2.
//  Copyright © 2017年  as7. All rights reserved.
//

#import "AMCollectionViewCell.h"
#import "AMCollectionView.h"

#define kRZCTEditingButtonWidth       60.0
#define kRZCTEditStateAnimDuration    0.3
#define KactionCount 2

@interface AMCollectionViewCell () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *customContentView;
@property (nonatomic, weak) UIPanGestureRecognizer *panGesture;

@end


@implementation AMCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureGestures];
}
- (void)configureGestures
{
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.customContentView addGestureRecognizer:panGesture];
    self.customContentView.backgroundColor = [UIColor yellowColor];
    panGesture.delegate = self;
    panGesture.enabled  = YES;
    self.panGesture     = panGesture;
}

#pragma mark - Pan Gesture handlers

- (void)handlePan:(UIPanGestureRecognizer *)panGesture
{
    static CGFloat initialTranslationX = 0;
    
    CGPoint           translation      = [panGesture translationInView:self];
    CGAffineTransform currentTransform = self.customContentView.transform;
    CGFloat           maxTransX        = -kRZCTEditingButtonWidth * KactionCount;
    
    switch ( panGesture.state ) {
        case UIGestureRecognizerStateBegan:
            
            initialTranslationX = currentTransform.tx;
            
        case UIGestureRecognizerStateChanged: {
            CGFloat targetTranslationX = initialTranslationX + translation.x;
            targetTranslationX = MIN(0, targetTranslationX); // must be negative (left)
            
            if ( targetTranslationX < maxTransX ) {
                CGFloat overshoot = maxTransX - targetTranslationX;
                targetTranslationX = maxTransX - overshoot * 0.3333;
            }
            
            self.customContentView.transform = CGAffineTransformMakeTranslation(targetTranslationX, 0);
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled: {
            if ( currentTransform.tx < maxTransX ) {
                [self setEditing:YES animated:YES];
            }
            else {
                [self setEditing:NO animated:YES];
            }
        }
            break;
        default:
            break;
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    _isEditing = editing;
    
    self.customContentView.userInteractionEnabled = !editing;
    
    CGFloat stopTarget = editing ? ( -kRZCTEditingButtonWidth * KactionCount ) : 0;
    if ( animated ) {
        [UIView animateWithDuration:kRZCTEditStateAnimDuration
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             self.customContentView.transform = CGAffineTransformMakeTranslation(stopTarget, 0);
                         } completion:nil];
    }
    else {
        self.customContentView.transform = CGAffineTransformMakeTranslation(stopTarget, 0);
    }
    
    [(AMCollectionView *)self.collectionView editingStateChangedForCell:self];
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    BOOL shouldBegin = NO;
    if ( gestureRecognizer == self.panGesture ) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint                vel  = [pan velocityInView:self];
        if ( fabs(vel.x) > fabs(vel.y) ) {
            shouldBegin = YES;
        }
    }
    else if ( [super respondsToSelector:@selector(gestureRecognizerShouldBegin:)] ) {
        shouldBegin = [super gestureRecognizerShouldBegin:gestureRecognizer];
    }
    return shouldBegin;
}


@end
