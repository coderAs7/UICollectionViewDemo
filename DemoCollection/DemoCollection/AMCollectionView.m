//
//  AMCollectionView.m
//  DemoCollection
//
//  Created by  as7 on 17/9/2.
//  Copyright © 2017年  as7. All rights reserved.
//

#import "AMCollectionView.h"


@interface AMCollectionView ()

@property (nonatomic, assign) BOOL inEditingConfirmationState;

@end

@implementation AMCollectionView
- (void)reloadData
{
    [super reloadData];
    self.panGestureRecognizer.enabled = YES;
}
- (void)editingStateChangedForCell:(AMCollectionViewCell *)cell
{
    if ( cell != nil && [self.visibleCells containsObject:cell] ) {
        if ( cell.isEditing ) {
            [self enterConfirmationStateForCell:cell];
        }
    }
}

- (void)enterConfirmationStateForCell:(AMCollectionViewCell *)cell
{
    [self.visibleCells enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ( [obj isKindOfClass:[AMCollectionViewCell class]] && obj != cell ) {
            [(AMCollectionViewCell *)obj setEditing:NO animated:YES];
        }
    }];
    self.panGestureRecognizer.enabled = NO;
    self.inEditingConfirmationState   = YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ( self.inEditingConfirmationState ) {
        [self endConfirmationState];
    }
    else {
        [super touchesBegan:touches withEvent:event];
    }
}
- (void)endConfirmationState
{
    [self.visibleCells enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ( [obj isKindOfClass:[AMCollectionViewCell class]] ) {
            [(AMCollectionViewCell *)obj setEditing:NO animated:YES];
        }
    }];
    self.panGestureRecognizer.enabled = YES;
    self.inEditingConfirmationState   = NO;
}
@end
