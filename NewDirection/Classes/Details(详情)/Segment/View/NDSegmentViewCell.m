//
//  NDSegmentViewCell.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/28.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDSegmentViewCell.h"
#import "NDSegmentParam.h"

@interface NDSegmentViewCell ()
@property (nonatomic ,strong) NDSegmentParam *segmentParam;
@end

@implementation NDSegmentViewCell

- (void)updateTitle:(NSString *)title segmentParam:(NDSegmentParam *)segmentParam
{
    self.segmentParam = segmentParam;
    self.textLabel.frame = self.contentView.bounds;
    self.textLabel.text = title;
}

- (void)didSelected:(BOOL)selected
{
    self.textLabel.textColor = selected ? self.segmentParam.selectedColor : self.segmentParam.defaultColor;
    self.textLabel.font = [UIFont systemFontOfSize:self.segmentParam.fontSize];
}

- (UILabel *)textLabel
{
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont systemFontOfSize:self.segmentParam.fontSize];
        _textLabel.textColor = self.segmentParam.selectedColor;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_textLabel];
    }
    return _textLabel;
}
@end
