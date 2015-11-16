//
//  filterValieView.h
//  YWFilterPicker
//
//  Created by ChouGii on 15/9/18.
//  Copyright (c) 2015年 zyw. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol filterValueViewDelegate <NSObject>
@required
/**
 *  选择完成
 *
 *
 */
-(void)seleteFinishedCallBack:(NSArray *)filters andFatherId:(NSString *)fatherid;
@end

@interface filterValueView : UIView
/**
 *  父分类id
 */
@property (nonatomic,strong) NSString * fatherId;
/**
 *  父分类名
 */
@property (nonatomic,copy) NSString * fatherName;
/**
 *  选中的选项
 */
@property (nonatomic,strong) NSMutableArray * filters;
@property (nonatomic,weak) id<filterValueViewDelegate> delegate;

/**
 *  选项数据（tableView数据源）
 */
@property (nonatomic,strong) NSMutableArray * categorys;
-(instancetype)initWithFatherId:(NSString *)fatherId andFatherName:(NSString *)fathername;
@end
