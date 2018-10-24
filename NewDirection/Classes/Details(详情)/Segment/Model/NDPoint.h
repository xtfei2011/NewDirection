//
//  NDPoint.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/19.
//  Copyright © 2018 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NDPoint : NSObject
@property (copy,nonatomic)NSString  *point_depth;  //知识点深度
@property (assign,nonatomic)BOOL    point_expand;  //知识点展开与否

@property (copy,nonatomic)NSString  *point_id;
@property (copy,nonatomic)NSString  *point_knowid;
@property (copy,nonatomic)NSString  *point_name;
@property (copy,nonatomic)NSString  *point_pid;
@property (copy,nonatomic)NSString  *point_pidA;
@property (copy,nonatomic)NSString  *point_qNum;
@property (copy,nonatomic)NSString  *point_url;
@property (copy,nonatomic)NSString  *point_son;  //作为判断是否有子节点的条件
@property (strong,nonatomic)NSArray *point_son1; //子知识点

-(instancetype)initWithPointDic:(NSDictionary *)pointDic;
@end

NS_ASSUME_NONNULL_END
