//
//  NDTreeTableView.m
//  NewDirection
//
//  Created by 谢腾飞 on 2018/10/19.
//  Copyright © 2018 谢腾飞. All rights reserved.
//

#import "NDTreeTableView.h"
#import "NDTreeTableCell.h"
#import "NDNode.h"

@interface NDTreeTableView ()<UITableViewDataSource ,UITableViewDelegate>

@property (nonatomic ,strong) NSArray *data;
@property (nonatomic ,strong) NSMutableArray *tempData;

@end

@implementation NDTreeTableView

- (instancetype)initWithFrame:(CGRect)frame andData:(NSArray *)data
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.rowHeight = 50;
        
        _data = data;
        _tempData = [self createTempData:data];
    }
    return self;
}

/*** 初始化数据 ***/
- (NSMutableArray *)createTempData:(NSArray *)data
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < data.count; i++) {
        
        NDNode *node = [_data objectAtIndex:i];
        if (node.expand) {
            [tempArray addObject:node];
        }
    }
    return tempArray;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tempData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NDTreeTableCell *cell = [NDTreeTableCell cellWithTableView:tableView];
    
    NDNode *node = [_tempData objectAtIndex:indexPath.row];
    
    cell.indentationLevel = node.depth;
    cell.indentationWidth = 30.f;
    cell.textLabel.text = node.name;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NDNode *parentNode = [_tempData objectAtIndex:indexPath.row];
    
    if (_cellDelegate && [_cellDelegate respondsToSelector:@selector(treeTableViewCellClick:)]) {
        [_cellDelegate treeTableViewCellClick:parentNode];
    }
    
    NSUInteger startPosition = indexPath.row + 1;
    NSUInteger endPosition = startPosition;
    BOOL expand = NO;
    
    for (int i = 0; i < _data.count; i ++) {
        
        NDNode *node = [_data objectAtIndex:i];
        if (node.parentId == parentNode.nodeId) {
            node.expand = !node.expand;
            
            if (node.expand) {
                [_tempData insertObject:node atIndex:endPosition];
                expand = YES;
                endPosition ++;
            } else {
                expand = NO;
                endPosition = [self removeAllNodesAtParentNode:parentNode];
                break;
            }
        }
    }
    
    //获得需要修正的indexPath
    NSMutableArray *indexPathArray = [NSMutableArray array];
    for (NSUInteger i = startPosition; i < endPosition; i++) {
        NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [indexPathArray addObject:tempIndexPath];
    }
    
    //插入或者删除相关节点
    if (expand) {
        [self insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
    } else {
        [self deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (NSUInteger)removeAllNodesAtParentNode:(NDNode *)parentNode
{
    NSUInteger startPosition = [_tempData indexOfObject:parentNode];
    NSUInteger endPosition = startPosition;
    for (NSUInteger i=startPosition+1; i<_tempData.count; i++) {
        NDNode *node = [_tempData objectAtIndex:i];
        endPosition++;
        if (node.depth <= parentNode.depth) {
            break;
        }
        if(endPosition == _tempData.count-1){
            endPosition++;
            node.expand = NO;
            break;
        }
        node.expand = NO;
    }
    if (endPosition>startPosition) {
        [_tempData removeObjectsInRange:NSMakeRange(startPosition+1, endPosition-startPosition-1)];
    }
    return endPosition;
}
@end
