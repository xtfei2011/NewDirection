//
//  NDLiveHeaderView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/26.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDLiveHeaderView.h"

@interface NDLiveHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation NDLiveHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSection:(NSInteger)section
{
    _section = section;
    
    self.titleLabel.text = (section == 0) ? @"直播间" : @"直播预告";
}

@end
