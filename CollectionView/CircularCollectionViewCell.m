//
//  CircularCollectionViewCell.m
//  CollectionView
//
//  Created by Zhangziyi on 16/7/7.
//  Copyright © 2016年 GLaDOS. All rights reserved.
//

#import "CircularCollectionViewCell.h"
#import "CircularCollectionViewLayoutAttributes.h"
@implementation CircularCollectionViewCell

- (void)setString:(NSString *)string{
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
    CircularCollectionViewLayoutAttributes* circularlayoutAttributes = (CircularCollectionViewLayoutAttributes*)layoutAttributes;
    
    self.layer.anchorPoint = circularlayoutAttributes.anchorPoint;
    
    CGFloat num1 = circularlayoutAttributes.anchorPoint.y - 0.5;
    CGFloat num2 = self.bounds.size.height;
    
    CGPoint center = self.center;
    center.y += num1 * num2;
    self.center = center;
}
@end
