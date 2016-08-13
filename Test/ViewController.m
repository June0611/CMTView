//
//  ViewController.m
//  Test
//
//  Created by Nile on 16/8/9.
//  Copyright © 2016年 Nile. All rights reserved.
//

#import "ViewController.h"
#import "GGCMTView.h"
#import "CustomTableViewCell.h"
#import "UIView+Frame.h"

static NSString * reuseIdentifier = @"cell";
@interface ViewController ()<cmtViewDelegate,cmtViewDataSource>

@property(nonatomic,strong)NSArray * dataArr;
@property(nonatomic,strong)GGCMTView * cmtView1;
@property(nonatomic,strong)GGCMTView * cmtView2;

@end

@implementation ViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.cmtView1 pauseScroll];
    [self.cmtView2 pauseScroll];
    
}

- (NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = @[@"测试1",@"测试2",@"测试3",@"测试4",@"测试5",@"测试6",@"测试7",@"测试8",@"测试9",@"测试10"];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self testCMTView];
    [self testCMTView2];
    
}


- (void)testCMTView{
    GGCMTView * cmtView = [[GGCMTView alloc]initWithFrame:CGRectMake(0, 100, self.view.width, 200) andCMTViewStyle:CMTViewHorizontalStyle];
    cmtView.timeInterval = 4.0f;
    cmtView.enableUserScroll = YES;
    [self.view addSubview:cmtView];
    cmtView.dataSource = self;
    cmtView.delegate = self;
    self.cmtView1 = cmtView;
    [cmtView prepareScroll];
//    [cmtView startScroll];
}

- (void)testCMTView2{
    GGCMTView * cmtView = [[GGCMTView alloc]initWithFrame:CGRectMake(0, 330, self.view.width, 200) andCMTViewStyle:CMTViewVerticalStyle];
    cmtView.timeInterval = 4.0f;
    cmtView.enableUserScroll = YES;
    [self.view addSubview:cmtView];
    cmtView.dataSource = self;
    cmtView.delegate = self;
    self.cmtView2 = cmtView;
    [cmtView prepareScroll];
    [cmtView startScroll];
}

- (UITableViewCell *)cmtView:(GGCMTView *)cmtView cellForIndex:(NSInteger)index{
    
    CustomTableViewCell * cell = [CustomTableViewCell customTableViewCellWithTableView:cmtView];
    cell.cust.text = self.dataArr[index];
    return cell;
}

- (void)cmtView:(GGCMTView *)cmtView didSelectIndex:(NSInteger)index{
    
    NSLog(@"%ld",(long)index);
}

- (NSInteger)numberOfPageInCmtView:(GGCMTView *)cmtView{
    return self.dataArr.count;
}


@end
