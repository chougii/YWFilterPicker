//
//  fatherCell.m
//  YWFilterPicker
//
//  Created by ChouGii on 15/9/21.
//  Copyright © 2015年 zyw. All rights reserved.
//

#import "fatherCell.h"
#import "filterModel.h"
@interface fatherCell()

@end
@implementation fatherCell

- (void)awakeFromNib {
    // Initialization code
}

+(instancetype)cellWithTableView:(UITableView *)tabelView
{
    static NSString *ID = @"Father";
    fatherCell *cell = [tabelView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[fatherCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
    lblName.frame = CGRectMake(10, 5, 200, 30);
    lblName.text = category.cname;
    lblName.font = [UIFont systemFontOfSize:12];
    
    [self.contentView addSubview:lblName];
    //最右侧进入的小箭头
    UIButton * btnGo = [[UIButton alloc] init];
    btnGo.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-40-40, 10, 20, 20);
    [btnGo setImage:[UIImage imageNamed:@"in"] forState:UIControlStateNormal];
    
    [self.contentView addSubview:btnGo];
    //右侧值的label
    UILabel * lblDetail = [[UILabel alloc] init];
    [lblDetail setText:@"全部"];
    [lblDetail setTextColor:[UIColor grayColor]];
    lblDetail.frame = CGRectMake(btnGo.frame.origin.x-150, 0, 150, 40);
    [lblDetail setTextAlignment:NSTextAlignmentRight];
    lblDetail.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:lblDetail];
    self.lblDetail = lblDetail;
    
    
}

-(void)chengeDetail:(NSString *)Fiters
{
    NSString * str = Fiters;
    if (Fiters.length>15) {
        str = [str substringToIndex:12];
        str = [str stringByAppendingFormat:@"..."];
    }
    self.lblDetail.text = str;
}






@end
