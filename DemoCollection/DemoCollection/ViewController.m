//
//  ViewController.m
//  DemoCollection
//
//  Created by  as7 on 17/9/2.
//  Copyright © 2017年  as7. All rights reserved.
//

#import "ViewController.h"
#import "AMCollectionView.h"




@interface ViewController () <UICollectionViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 200);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    AMCollectionView *c = [[AMCollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    [c registerNib:[UINib nibWithNibName:NSStringFromClass([AMCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([AMCollectionViewCell class])];
    c.dataSource = self;
    
    [self.view addSubview:c];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AMCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([AMCollectionViewCell class]) forIndexPath:indexPath];
    cell.collectionView = collectionView;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
