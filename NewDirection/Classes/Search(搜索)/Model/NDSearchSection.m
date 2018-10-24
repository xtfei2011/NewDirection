//
//  NDSearchSection.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/16.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDSearchSection.h"
#import "NDSearch.h"

#define ND_DirectoryModel_SET_VALUE_FOR_STRING(dictname,value) dictionary[dictname]!= nil &&dictionary[dictname]!=[NSNull null]? dictionary[dictname] : value;

@interface NDSearchSection ()

@property (nonatomic ,strong) NSMutableArray *content_Array;
@end

@implementation NDSearchSection

- (NSMutableArray *)content_Array
{
    if (_content_Array == nil) {
        _content_Array = [NSMutableArray array];
    }
    return _content_Array;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self) {
        self.section_id = ND_DirectoryModel_SET_VALUE_FOR_STRING(@"section_id", @"0");
        self.section_title = ND_DirectoryModel_SET_VALUE_FOR_STRING(@"section_title", @"");
        NSArray *emp = ND_DirectoryModel_SET_VALUE_FOR_STRING(@"section_content",@[]);
        
        if (emp.count > 0) {
            for (NSDictionary *content_dict in emp) {
                NDSearch *model = [[NDSearch alloc] initWithDictionary:content_dict];
                [self.content_Array addObject:model];
            }
            self.section_Array = self.content_Array;
        }
    }
    return self;
}
@end
