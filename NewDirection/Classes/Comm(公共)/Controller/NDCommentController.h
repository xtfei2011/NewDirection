//
//  NDCommentController.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/26.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDStore.h"

@interface NDCommentController : UITableViewController

@property (nonatomic ,assign) NDSegmentedType type;

/*** 加载头部视图 ***/
- (void)setupHeaderView:(NSString *)imageName;
@end
