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

@property(nonatomic,strong)NSArray * dataArr1;
@property(nonatomic,strong)NSArray * dataArr2;
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

- (NSArray *)dataArr1{
    if (!_dataArr1) {
        _dataArr1 = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg"];
    }
    return _dataArr1;
}
- (NSArray *)dataArr2{
    if (!_dataArr2) {
        _dataArr2 = @[@"7.jpg",@"6.jpg",@"5.jpg",@"4.jpg",@"3.jpg",@"2.jpg",@"1.jpg"];
    }
    return _dataArr2;
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
    [cmtView startScroll];
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
    if (cmtView == self.cmtView1) {
        cell.image.image = [UIImage imageNamed:self.dataArr1[index]];
        cell.cust.text = self.dataArr1[index];
    }else{
        cell.image.image = [UIImage imageNamed:self.dataArr2[index]];
        cell.cust.text = self.dataArr2[index];
    }
    return cell;
}

- (void)cmtView:(GGCMTView *)cmtView didSelectIndex:(NSInteger)index{
    if (cmtView == self.cmtView1) {
        NSLog(@"第%ld张   =====   名字是 %@",(long)index,self.dataArr1[index]);
    }else{
        NSLog(@"第%ld张   =====   名字是 %@",(long)index,self.dataArr2[index]);
    }
    
}

- (NSInteger)numberOfPageInCmtView:(GGCMTView *)cmtView{
    
    if (cmtView == self.cmtView1) {
        return self.dataArr1.count;
    }
    return self.dataArr2.count;
}


@end
