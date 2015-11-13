//
//  categoryCell.m
//  YWFilterPicker
//
//  Created by ChouGii on 15/9/18.
//  Copyright (c) 2015年 zyw. All rights reserved.
//

#import "categoryCell.h"
@interface categoryCell()
@property (nonatomic,strong) UIButton * rightBtn;
@end
@implementation categoryCell

+(instancetype)cellWithTableView:(UITableView *)tabelView
{
    NSString *ID = [NSString stringWithFormat:@"%d",arc4random()];
    categoryCell *cell = [tabelView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[categoryCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }else{
        
        for (UIView *subView in cell.contentView.subviews)
        {
            [subView removeFromSuperview];
        }
    }
    return cell;

}
-(void)setCategory:(filterModel *)category
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _category = category;
    UILabel * lblName = [[UILabel alloc] init];
    lblName.frame = CGRectMake(10, 7, 200, 30);
    lblName.text = category.cname;
    lblName.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:lblName];
    
    [self setupRightImage];
}

-(void)setupRightImage
{
    UIButton * btn = [[UIButton alloc] init];
    btn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-90, 5, 30, 30);
    [btn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.rightBtn = btn;
}

-(void)showRightButton
{
    [self.contentView addSubview:self.rightBtn];
    self.isShowing = YES;
}

-(void)hideRightButton
{
    [self.rightBtn removeFromSuperview];
    self.isShowing = NO;
}

@end