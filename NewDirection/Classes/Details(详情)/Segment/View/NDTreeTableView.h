//
//  NDTreeTableView.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/19.
//  Copyright © 2018 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class NDNode;
@protocol NDTreeTableCellDelegate <NSObject>

- (void)treeTableViewCellClick:(NDNode *)node;
@end

@interface NDTreeTableView : UITableView

@property (nonatomic ,weak) id<NDTreeTableCellDelegate>cellDelegate;

- (instancetype)initWithFrame:(CGRect)frame andData:(NSArray *)data;
@end

NS_ASSUME_NONNULL_END
