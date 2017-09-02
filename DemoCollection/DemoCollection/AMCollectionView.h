//
//  AMCollectionView.h
//  DemoCollection
//
//  Created by  as7 on 17/9/2.
//  Copyright © 2017年  as7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMCollectionViewCell.h"

@interface AMCollectionView : UICollectionView
- (void)editingStateChangedForCell:(AMCollectionViewCell *)cell;
@end
