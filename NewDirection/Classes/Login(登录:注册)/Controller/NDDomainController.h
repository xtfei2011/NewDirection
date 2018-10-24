//
//  NDDomainController.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/11.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^DomainSignature)(NSString *text);
@interface NDDomainController : UIViewController
@property (nonatomic ,strong) DomainSignature signature;
@end

NS_ASSUME_NONNULL_END
