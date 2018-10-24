//
//  NDSearchSection.h
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/16.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NDSearchSection : NSObject

@property (nonatomic ,copy) NSString *section_id;
@property (nonatomic ,copy) NSString *section_title;
@property (nonatomic ,copy) NSArray *section_Array;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END
