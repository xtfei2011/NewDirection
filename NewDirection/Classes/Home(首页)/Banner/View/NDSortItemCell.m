//
//  NDSortItemCell.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/25.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDSortItemCell.h"

@interface NDSortItemCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation NDSortItemCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)setIndex:(NSInteger)index
{
    _index = index;
    
    self.iconView.image = [UIImage imageNamed:SortImageArray[index]];
    self.titleLabel.text = SortTitleArray[index];
}
@end
