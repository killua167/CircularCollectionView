//
//  ViewController.m
//  CollectionView
//
//  Created by Zhangziyi on 16/7/5.
//  Copyright © 2016年 GLaDOS. All rights reserved.
//

#import "ViewController.h"
#import "MyLayout.h"
#import "CircularCollectionViewCell.h"
#import "CircularCollectionViewLayoutAttributes.h"
@interface ViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    MyLayout *circularLayout = [[MyLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:circularLayout];
    [self.view addSubview:_collectionView];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[CircularCollectionViewCell class] forCellWithReuseIdentifier:@"reused"];
}
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(96, 100);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CircularCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reused" forIndexPath:indexPath];
//    CircularCollectionViewLayoutAttributes *attributes = (CircularCollectionViewLayoutAttributes*)[collectionView layoutAttributesForItemAtIndexPath:indexPath];
//    
//    [CircularCollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    
//    [cell applyLayoutAttributes:attributes];
    CGFloat colorR = arc4random()%255 / 255.0;
    CGFloat colorG = arc4random()%255 / 255.0;
    CGFloat colorB = arc4random()%255 / 255.0;
    cell.backgroundColor = [UIColor colorWithRed:colorR green:colorG blue:colorB alpha:1];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
