//
//  NDSegmentViewCell.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/28.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NDSegmentParam;
@interface NDSegmentViewCell : UICollectionViewCell

@property (nonatomic ,strong) UILabel *textLabel;

- (void)updateTitle:(NSString *)title segmentParam:(NDSegmentParam *)segmentParam;
- (void)didSelected:(BOOL)selected;

@end
