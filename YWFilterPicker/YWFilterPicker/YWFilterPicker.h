//
//  YWFilterPicker.h
//  YWFilterPicker
//
//  Created by ChouGii on 15/9/17.
//  Copyright (c) 2015年 zyw. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YWFilterPickerDelegate <NSObject>

@required
/**
 *  确认筛选条件后的回调方法
 *
 *  @param Filter 字典-> 父类id:fitlerModel数组
 */
-(void)YWFilterPickerFinishedPickkingFilter:(NSDictionary *)Filter;
-(void)YWFilterPickerCancelled;
@end

@interface YWFilterPicker : UIScrollView


@property (nonatomic,assign) id<YWFilterPickerDelegate> delegate;
@property (nonatomic,strong) NSMutableArray * categorys;
@property (nonatomic,copy) NSString * jsonData;
@property (nonatomic,strong) NSDictionary * dictData;
/**
 *  将数据转化成通用字典类型方便网络传值
 *=;
 *  @param filters  筛选值数组
 *  @return 字典->[id:filterid]
 */
+(NSDictionary *)dictWithAllFilters:(NSDictionary *) allfilters;

@end
