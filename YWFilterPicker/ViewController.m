//
//  ViewController.m
//  YWFilterPicker
//
//  Created by ChouGii on 15/9/17.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "ViewController.h"
#import "YWFilterPicker.h"

@interface ViewController ()<YWFilterPickerDelegate>{
    CGRect screenBounds;
}
@property (nonatomic,weak) UILabel * lblFilter;
@property (nonatomic,strong) NSDictionary * filtersCatch;
@property (nonatomic,weak) UIView * cover;
@property (nonatomic,strong) NSMutableDictionary * seletedFilter;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.filtersCatch = [NSDictionary dictionary];
    screenBounds = [UIScreen mainScreen].bounds;
    UIView * view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
    view.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1];
    [self.view addSubview:view];
    UIButton * btn = [[UIButton alloc] init];
    [btn setTitle:@"筛选" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    btn.frame = CGRectMake(view.bounds.size.width-60, 30, 60,30);
    [view addSubview:btn];
    [btn addTarget:self action:@selector(filterPicker) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * lblFilter= [[UILabel alloc] init];
    lblFilter.frame = CGRectMake(10, 100, 320 ,30);
    lblFilter.backgroundColor = [UIColor whiteColor];
    [lblFilter setTextColor:[UIColor blackColor]];
    [self.view addSubview:lblFilter];
    self.lblFilter = lblFilter;
    
}

/**
 *  添加属性选择器
 */
-(void)filterPicker
{
    YWFilterPicker * picker = [[YWFilterPicker alloc] init];
    picker.delegate = self;
    picker.dictData = [self getDictData];
    [self.view addSubview:picker];
}


-(NSDictionary *)getDictData
{
    NSDictionary *dict = @{
       @"filters" : @[@{
                   @"cid" : @"c001",
                   @"cname":@"color",
                   @"cvaluemodels" : @[@{
                       @"cid" : @"c101",
                       @"cname" : @"white",
                       @"cvaluemodels":@""
                       },@{@"cid" : @"c102",
                           @"cname" : @"black",
                           @"cvaluemodels":@""}]},
                    @{
                       @"cid":@"c002",
                       @"cname" : @"size",
                       @"cvaluemodels" : @[@{
                               @"cid" : @"c021",
                               @"cname" : @"M",
                               @"cvaluemodels":@""
                               },@{@"cid" : @"c022",
                                   @"cname" : @"L",
                                   @"cvaluemodels":@""
                                   },@{@"cid" : @"c023",
                                       @"cname" : @"XL",
                                       @"cvaluemodels":@""
                                       }]
                       }]};
    return dict;
}

/**
 *  YWFilterPicker代理事件
 *
 *  @param 所选筛选条件字典->key:cid value:filterModels
 */
-(void)YWFilterPickerFinishedPickkingFilter:(NSDictionary *)Filter
{
    self.filtersCatch=Filter;
   //格式化参数为[分类id:值id数组]的形式
   NSDictionary * dict =  [YWFilterPicker dictWithAllFilters:Filter];
   //便利数组输出
    NSString * str  = @"";
    for (NSString * fid in [dict allKeys]) {
        str= [str stringByAppendingFormat:@"%@:{",fid];
        for (NSString * cid in [dict objectForKey:fid]) {
            
            str=[str stringByAppendingFormat:@"%@,",cid];
        }
        str= [str substringToIndex:str.length-1];
        str=[str stringByAppendingString:@"},"];
    }
    if (str.length>0) {
        str= [str substringToIndex:str.length-1];

    }
    self.lblFilter.text = [NSString stringWithFormat:@"%@",str];
    self.lblFilter.textColor = [UIColor blackColor];
    self.lblFilter.font = [UIFont systemFontOfSize:11];
    self.seletedFilter = [NSMutableDictionary dictionaryWithDictionary:Filter];
    
}

-(void)YWFilterPickerCancelled
{
    
}


@end
