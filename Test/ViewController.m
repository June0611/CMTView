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
#import <objc/runtime.h>
#import "RSATool.h"
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
        _dataArr1 = @[@"8.png",@"9.png",@"10.png",@"11.png",@"12.png",@"13.png",@"14.png",@"15.png",@"16.png"];
    }
    return _dataArr1;
}
- (NSArray *)dataArr2{
    if (!_dataArr2) {
        _dataArr2 = @[@"8.png",@"9.png",@"10.png",@"11.png",@"12.png",@"13.png",@"14.png",@"15.png",@"16.png"];
    }
    return _dataArr2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self testRSAEncrpt];
//    [self testUDID];
    [self testCMTView];
    [self testCMTView2];
    
}



- (void)testRSAEncrpt{
    NSString * tmp = @"使用字符串格式的公钥私钥加密解密";
    NSLog(@"加密前:%@",tmp);
    tmp = [RSATool encryptString:tmp];
    NSLog(@"加密后:%@",tmp);
    tmp = [RSATool decryptString:tmp];
    NSLog(@"解密后:%@",tmp);
}

- (void)testUDID{
    NSString *className = NSStringFromClass([UIDevice class]);
    
    
    const char *cClassName = [className UTF8String];
    
    id theClass = objc_getClass(cClassName);
    
    unsigned int outCount;
    
    
    Method *m =  class_copyMethodList(theClass,&outCount);
    
    NSLog(@"%d",outCount);
    for (int i = 0; i<outCount; i++) {
        SEL a = method_getName(*(m+i));
        NSString *sn = NSStringFromSelector(a);
        NSLog(@"%@",sn);
    }
}



- (void)testCMTView{
    GGCMTView * cmtView = [[GGCMTView alloc]initWithFrame:CGRectMake(0, 100, self.view.width, 200) andCMTViewStyle:CMTViewHorizontalStyle];
    cmtView.timeInterval = 1.0f;
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
