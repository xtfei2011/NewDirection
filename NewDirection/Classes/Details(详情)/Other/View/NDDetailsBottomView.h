//
//  NDDetailsBottomView.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/13.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDStore.h"
#import "NDComment.h"

NS_ASSUME_NONNULL_BEGIN

@interface NDDetailsBottomView : UIView

@property (nonatomic ,assign) NDSegmentedType type;
@property (nonatomic ,strong) NDComment *comment;
@end

NS_ASSUME_NONNULL_END
