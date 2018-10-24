//
//  NDSegmentHeaderView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/28.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDSegmentHeaderView.h"

@interface NDSegmentHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *coverView;
@property (weak, nonatomic) IBOutlet UILabel *problemLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *writerLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;

@end

@implementation NDSegmentHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.frame = CGRectMake(0, 0, NDMainScreen_Width, 170);
    
    [self.coverView sd_setImageWithURL:[NSURL URLWithString:@"http://m.qpic.cn/psb?/V13Js1iM3urn8H/dBNckrA7EkbOCAffoomYS0qhcBfKN113JAIteMDHAY8!/b/dC4BAAAAAAAA&bo=wAFQAQAAAAADF6I!&rf=viewer_4"]];
}
@end
