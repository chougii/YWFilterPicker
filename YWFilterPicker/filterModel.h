//
//  filterModel.h
//  YWFilterPicker
//
//  Created by ChouGii on 15/9/18.
//  Copyright (c) 2015年 zyw. All rights reserved.
//  实体类

#import <Foundation/Foundation.h>

@interface filterModel : NSObject
/**
 *  分类id
 */
@property (nonatomic,strong) NSString * cid;
/**
 *  分类名
 */
@property (nonatomic,copy) NSString * cname;

@property (nonatomic,strong) NSMutableArray * cvaluemodels;

@end
