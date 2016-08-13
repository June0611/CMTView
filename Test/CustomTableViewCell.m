//
//  CustomTableViewCell.m
//  Test
//
//  Created by Nile on 16/8/9.
//  Copyright © 2016年 Nile. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "GGCMTView.h"
static NSString * cellId = @"TableViewCell";
@implementation CustomTableViewCell

+ (instancetype)customTableViewCellWithTableView:(GGCMTView *)cmtView
{
    UINib * nib = [UINib nibWithNibName:@"CustomTableViewCell" bundle:nil];
    [cmtView registerNib:nib forCMTViewCellReuseIdentifier:cellId];
    return [cmtView dequeueReusableCMTViewCellWithIdentifier:cellId];
}

@end
