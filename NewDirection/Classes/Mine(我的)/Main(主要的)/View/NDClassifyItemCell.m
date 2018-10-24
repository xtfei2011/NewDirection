//
//  NDClassifyItemCell.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/9.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDClassifyItemCell.h"

@interface NDClassifyItemCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation NDClassifyItemCell

#define classifyItemImages @[@"mine_course" ,@"mine_live" ,@"mine_face_to_face" ,@"mine_collection" ,@"mine_announcement" ,@"mine_opinion" ,@"mine_about" ,@"mine_set"]
#define classifyItemTitles @[@"我的课程" ,@"我的直播" ,@"我的面授" ,@"我的收藏" ,@"勘误公告" ,@"意见反馈" ,@"关于我们" ,@"应用设置"]

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setIndex:(NSInteger)index
{
    _index = index;
    
    self.iconView.image = [UIImage imageNamed:classifyItemImages[index]];
    self.titleLabel.text = classifyItemTitles[index];
}
@end
