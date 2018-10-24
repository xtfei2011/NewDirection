//
//  NDDBHandle.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/16.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDDBHandle.h"
#import "FMDatabase.h"

@implementation NDDBHandle
static FMDatabase *_db;

+ (void)initialize
{
    // 1.打开数据库
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"SearchModel.sqlite"];
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    
    // 2.创表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_searchModel (id integer PRIMARY KEY, searchModel blob NOT NULL, searchModel_idstr varchar NOT NULL);"];
}


+ (NSDictionary *)statusesWithParams:(NSDictionary *)params
{
    // 根据请求参数生成对应的查询SQL语句
    NSString *sql = nil;
    if (params[@"category"]) {
        sql = [NSString stringWithFormat:@"SELECT * FROM t_searchModel WHERE searchModel_idstr = %@ ;", params[@"category"]];
    }else{
        sql = @"SELECT * FROM t_searchModel;";
    }
    // 执行SQL
    FMResultSet *set = [_db executeQuery:sql];
    while (set.next) {
        NSData *statusData = [set objectForColumn:@"SearchModel"];
        NSDictionary *status = [NSKeyedUnarchiver unarchiveObjectWithData:statusData];
        return status;
    }
    return @{};
}


+ (void)saveStatuses:(NSDictionary *)statuses param:(NSDictionary *)param
{
    NSString *category = param[@"category"];
    
    [NDDBHandle delect:param[@"category"]];
    
    NSData *statusData = [NSKeyedArchiver archivedDataWithRootObject:statuses];
    [_db executeUpdateWithFormat:@"INSERT INTO t_searchModel(searchModel, searchModel_idstr) VALUES (%@, %@);", statusData, category];
}

+ (BOOL)delect:(NSString *)searchModel_idstr
{
    BOOL success = YES ;
    NSString * newSql = [NSString stringWithFormat:@"DELETE  FROM t_searchModel WHERE searchModel_idstr = ?"];
    BOOL isCan =  [_db executeUpdate:newSql,searchModel_idstr];
    if (!isCan) {
        success = NO;
    }
    return success;
}
@end
