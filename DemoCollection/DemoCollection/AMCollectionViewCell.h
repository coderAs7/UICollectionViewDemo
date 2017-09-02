//
//  AMCollectionViewCell.h
//  DemoCollection
//
//  Created by  as7 on 17/9/2.
//  Copyright © 2017年  as7. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AMCollectionViewCell : UICollectionViewCell

@property (nonatomic,weak) UICollectionView *collectionView;
@property (nonatomic, assign) BOOL isEditing;
- (void)setEditing:(BOOL)editing animated:(BOOL)animated;
@end
