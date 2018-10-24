//
//  NDCrossShakeDetailHeadView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/18.
//  Copyright © 2018 谢腾飞. All rights reserved.
//

#import "NDCrossShakeDetailHeadView.h"

@interface NDCrossShakeDetailHeadView ()
@property (weak, nonatomic) IBOutlet UIImageView *coverView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *problemLabel;
@end

@implementation NDCrossShakeDetailHeadView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.frame = CGRectMake(0, 0, NDMainScreen_Width, 170);
    
    [self.coverView sd_setImageWithURL:[NSURL URLWithString:@"http://m.qpic.cn/psb?/V13Js1iM3urn8H/Z9TTjgdHVb71Oz*JbuXM.ZUnq9GpIUL.2iXFN0wNTC8!/b/dDABAAAAAAAA&bo=2gSjAgAAAAADB10!&rf=viewer_4"]];
}
@end
