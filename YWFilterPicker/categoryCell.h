//
//  categoryCell.h
//  YWFilterPicker
//
//  Created by ChouGii on 15/9/18.
//  Copyright (c) 2015年 zyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "filterModel.h"

@interface categoryCell : UITableViewCell
@property (nonatomic,strong) filterModel * category;
@property (nonatomic,assign) BOOL isShowing;
+(instancetype)cellWithTableView:(UITableView*)tableView;
-(void)showRightButton;
-(void)hideRightButton;
@end
