//
//  MyLayout.m
//  CollectionView
//
//  Created by Zhangziyi on 16/7/5.
//  Copyright © 2016年 GLaDOS. All rights reserved.
//

#import "MyLayout.h"
#import "CircularCollectionViewLayoutAttributes.h"
@interface MyLayout ()
@property (assign, nonatomic) CGSize itemSize;
@property (nonatomic, assign) CGFloat angle;
@property (assign, nonatomic) CGFloat radius;
@property (assign, nonatomic) CGFloat anglePerItem;
@property (nonatomic, strong) NSArray* attributesList;
@property (nonatomic, assign) CGFloat angleAtExtreme;
@end
@implementation MyLayout

- (instancetype)init{
    self = [super init];
    if (self) {
        self.radius = 500;
        self.angle = 0;
        self.itemSize = CGSizeMake(133, 177);
    }
    return self;
}

- (CGSize)collectionViewContentSize{
    NSInteger number = [self.collectionView numberOfItemsInSection:0];
    return CGSizeMake(number*self.itemSize.width, self.collectionView.frame.size.height);
}
-(CGFloat)angle{
    //任意contentOffset.x对应的角度
    CGFloat a = -self.angleAtExtreme * self.collectionView.contentOffset.x;
    CGFloat b = [self collectionViewContentSize].width - self.collectionView.bounds.size.width;
    return a/b;
}

-(CGFloat)angleAtExtreme{
    if ([self.collectionView numberOfItemsInSection:0] > 0) {
        CGFloat resultAngleAtExtreme = ([self.collectionView numberOfItemsInSection:0] - 1) * self.anglePerItem;
        return resultAngleAtExtreme;
    }else{
        return 0;
    }
}

- (void)setRadius:(CGFloat)radius{
    _radius = radius;
    [self invalidateLayout];
}

- (CGFloat)anglePerItem{
    return atan(self.itemSize.width/self.radius);
}
- (void)prepareLayout{
    [super prepareLayout];
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    CGFloat anchorPointY = (self.itemSize.height/2.0 + self.radius)/self.itemSize.height;
    
    CGFloat theta = atan2(self.collectionView.bounds.size.width * 0.5, self.radius + (self.itemSize.height * 0.5) - self.collectionView.bounds.size.height * 0.5);
    
    int startIndex = 0;
    NSInteger endIndex = [self.collectionView numberOfItemsInSection:0] - 1;
    if (self.angle < -theta) {
        CGFloat a = (-theta - self.angle)/self.anglePerItem;
        startIndex = (int)(floor(a));
    }
    
    endIndex = MIN(endIndex, (int)(ceil((theta - self.angle)/self.anglePerItem)));
    
    if (endIndex < startIndex) {
        endIndex = 0;
        startIndex = 0;
    }
    
    NSMutableArray *indexPaths = [NSMutableArray array];
//    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    for (int i = startIndex; i < endIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [indexPaths addObject:indexPath];
    }
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    for (NSIndexPath *indexPath in indexPaths) {
        CircularCollectionViewLayoutAttributes *attributes = [CircularCollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.size = self.itemSize;
        attributes.center = CGPointMake(centerX, self.collectionView.center.y);
        attributes.angle = self.angle + self.anglePerItem * indexPath.row;
        attributes.anchorPoint = CGPointMake(0.5, anchorPointY);
        [layoutAttributes addObject:attributes];
    }
    self.attributesList = layoutAttributes;
}
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attributesList;
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.attributesList[indexPath.row];
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

@end
