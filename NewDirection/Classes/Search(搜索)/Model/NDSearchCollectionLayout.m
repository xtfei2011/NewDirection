//
//  NDSearchCollectionLayout.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/16.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDSearchCollectionLayout.h"

@implementation NDSearchCollectionLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.headerReferenceSize = CGSizeMake(NDMainScreen_Width, 50);
    self.minimumInteritemSpacing = 15;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    for (int i = 1; i < [attributes count]; ++ i) {
        
        UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
        UICollectionViewLayoutAttributes *prevLayoutAttributes = attributes[i - 1];
        
        if (prevLayoutAttributes.indexPath.section == currentLayoutAttributes.indexPath.section) {
            /*** 设置的最大间距 ***/
            NSInteger maximumSpacing = 15;
            //前一个cell的最右边
            NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
            
            if ((origin + maximumSpacing + currentLayoutAttributes.frame.size.width) < self.collectionViewContentSize.width) {
                
                CGRect frame = currentLayoutAttributes.frame;
                frame.origin.x = origin + maximumSpacing;
                currentLayoutAttributes.frame = frame;
            } else {
                NDLog(@"----->太长啦");
            }
        }
    }
    return attributes;
}
@end
