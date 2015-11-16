//
//  fatherCell.h
//  YWFilterPicker
//
//  Created by ChouGii on 15/9/21.
//  Copyright © 2015年 zyw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class filterModel;
@interface fatherCell : UITableViewCell
@property (nonatomic,strong) filterModel * category;
@property (nonatomic,weak) UILabel * lblDetail;
+(instancetype)cellWithTableView:(UITableView*)tableView;
-(void)chengeDetail:(NSString *)Fiters;
@end
