//
//  NDSearchCollectionCell.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/16.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDSearchCollectionCell.h"

@interface NDSearchCollectionCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation NDSearchCollectionCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSearch:(NDSearch *)search
{
    _search = search;
    
    self.titleLabel.text = search.search_content;
}

@end
