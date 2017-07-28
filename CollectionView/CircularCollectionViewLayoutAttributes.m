//
//  CircularCollectionViewLayoutAttributes.m
//  CollectionView
//
//  Created by Zhangziyi on 16/7/7.
//  Copyright © 2016年 GLaDOS. All rights reserved.
//

#import "CircularCollectionViewLayoutAttributes.h"
@interface CircularCollectionViewLayoutAttributes ()

@property (nonatomic, assign)int zIndex;
@property (nonatomic, assign)CGAffineTransform transform;
@end

@implementation CircularCollectionViewLayoutAttributes
@dynamic zIndex,transform;

- (void)setAngle:(CGFloat)angle{
    _angle = angle;
    self.zIndex = (int)(_angle * 100000);
    self.transform = CGAffineTransformMakeRotation(_angle);
}

- (id)copyWithZone:(NSZone *)zone{
    CircularCollectionViewLayoutAttributes* copiedAttributes = [super copyWithZone:zone];
    copiedAttributes.anchorPoint = self.anchorPoint;
    copiedAttributes.angle = self.angle;
    return copiedAttributes;
}
@end
