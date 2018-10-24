//
//  NDComment.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/12.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NDComment : NSObject

@property (nonatomic ,strong) NSString *title;
@property (nonatomic ,strong) NSString *original_price;
@property (nonatomic ,strong) NSString *currentPrice;
@property (nonatomic ,strong) NSString *image_path;
@property (nonatomic ,strong) NSString *big_image;
@property (nonatomic ,strong) NSString *writer;
@property (nonatomic ,strong) NSString *type;
/*** 课时数 ***/
@property (nonatomic ,strong) NSString *period;
@property (nonatomic ,strong) NSString *address;
@property (nonatomic ,strong) NSString *time;

@property (nonatomic ,strong) NSString *content;
@property (nonatomic ,strong) NSString *url;
@end

