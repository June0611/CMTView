//
//  CustomTableViewCell.h
//  Test
//
//  Created by Nile on 16/8/9.
//  Copyright © 2016年 Nile. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GGCMTView;
@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *cust;
+ (instancetype)customTableViewCellWithTableView:(GGCMTView *)cmtView;
@end
