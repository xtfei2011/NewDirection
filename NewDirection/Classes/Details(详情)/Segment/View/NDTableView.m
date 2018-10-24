//
//  NDTableView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/9/28.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "NDTableView.h"
#import "NDNode.h"
#import "NDTreeTableView.h"
#import "NDPoint.h"

@interface NDTableView ()<NDTreeTableCellDelegate>

@property (strong,nonatomic)NSMutableArray *Points;
@property (strong,nonatomic)NSMutableArray *allPoints;
@property (strong,nonatomic)NSArray *dataSourceArray;
@end

@implementation NDTableView

- (void)refreshContentView
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DataArray" ofType:@"plist"];
    _dataSourceArray = [[NSArray alloc] initWithContentsOfFile:filePath];
    
    [self initPoints];
}

- (void)initPoints
{
    
    //封装参数
    _Points = [NSMutableArray array];
    _allPoints = [NSMutableArray array];
    [_dataSourceArray enumerateObjectsUsingBlock:^(NSDictionary *pointDic, NSUInteger idx, BOOL * _Nonnull stop) {
        NDPoint *point = [[NDPoint alloc]initWithPointDic:pointDic];
        NSLog(@"--------%lu",(unsigned long)idx);
        point.point_depth = @"0";
        point.point_expand = YES;
        [self.Points addObject:point];
    }];
    NSLog(@"-----------%@",_Points);
    [self recursiveAllPoints:_Points];
    
    //创建Node节点
    NSMutableArray *nodes = [NSMutableArray array];
    [_allPoints enumerateObjectsUsingBlock:^(NDPoint *point, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //            NSLog(@"%@----%@----%@",point.point_name,point.point_knowid,point.point_pid);
        
        NDNode *node = [[NDNode alloc] initWithParentId:[point.point_pid integerValue] nodeId:[point.point_knowid integerValue] name:point.point_name depth:[point.point_depth integerValue] expand:point.point_expand];
        [nodes addObject:node];
    }];
    //TreeTableView
    NDTreeTableView *tableview = [[NDTreeTableView alloc] initWithFrame:self.bounds andData:nodes];
    tableview.cellDelegate = self;
    [self addSubview:tableview];
    
    
}
//递归所有的知识点
-(void)recursiveAllPoints:(NSMutableArray *)point_arrM
{
    __block int i = 0 ;
    __block NSString *parentId = nil ;
    
    [point_arrM enumerateObjectsUsingBlock:^(NDPoint *point, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.allPoints addObject:point];
        NSLog(@"----33333333----%@",point.point_depth);
        NSLog(@"==============%@",point.point_name);
        i = [point.point_depth intValue];
        parentId = point.point_knowid;
        
        if ([point.point_son isEqualToString:@"1"]) {
            i = i + 1;
            NSMutableArray *sonPoints = [NSMutableArray array];
            [point.point_son1 enumerateObjectsUsingBlock:^(NSDictionary *pointDic, NSUInteger idx, BOOL * _Nonnull stop) {
                NDPoint *point = [[NDPoint alloc]initWithPointDic:pointDic];
                
                NSLog(@"----1111111----%lu",(unsigned long)i);
                point.point_depth = [NSString stringWithFormat:@"%d",i];
                NSLog(@"----2222222----%@",point.point_depth);
                NSLog(@"-----------%@",point.point_name);
                point.point_pid = parentId;
                point.point_expand = NO;
                [sonPoints addObject:point];
            }];
            [self recursiveAllPoints:sonPoints];
        }else{
            i = 0 ;
            NSLog(@"==============");
        }
    }];
}
@end
