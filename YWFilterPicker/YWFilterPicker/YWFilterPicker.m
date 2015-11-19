//
//  YWFilterPicker.m
//  YWFilterPicker
//
//  Created by ChouGii on 15/9/17.
//  Copyright (c) 2015年 zyw. All rights reserved.
//

#import "YWFilterPicker.h"
#import "MJExtension.h"
#import "filterModel.h"
#import "filterValueView.h"
#import "fatherCell.h"
#import "coverView.h"
#import "MJExtension.h"
@interface YWFilterPicker()<UITableViewDataSource,UITableViewDelegate,filterValueViewDelegate>
@property (nonatomic,weak) UITableView * tableView;
@property (nonatomic,strong) NSIndexPath * currentIndex;
@property (nonatomic,strong) NSMutableDictionary * allFilters;
@property (nonatomic,weak) UIView * headerView;
@property (nonatomic,weak) UIView * coverView;
@property (nonatomic,assign) BOOL isFirstLayout;
@end
@implementation YWFilterPicker

-(instancetype)init
{
    if (self=[super init]) {
        CGRect screenBounds = [UIScreen mainScreen].bounds;
        self.categorys = [NSMutableArray array];
        self.allFilters = [NSMutableDictionary dictionary];
        self.frame = CGRectMake(50, 0, screenBounds.size.width-50, screenBounds.size.height);
        _isFirstLayout = YES;
    }
    return self;
}

-(void)layoutSubviews
{
     //遮盖层
    if (_isFirstLayout) {
        coverView * view = [[coverView alloc] init];
        view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        view.frame=[UIScreen mainScreen].bounds;
        view.backgroundColor = [[UIColor clearColor] colorWithAlphaComponent:0.7];
        [view addTarget:self action:@selector(btnCancelClick) forControlEvents:UIControlEventTouchUpInside];
        self.coverView = view;
        [UIView commitAnimations];
        [self.superview addSubview:view];
        [self.superview bringSubviewToFront:self];
        
        [self setupHeaderNavigation];
        [self setupFilterTable];

    }
    _isFirstLayout= NO;
}

-(void)setDictData:(NSDictionary *)dictData
{
    _dictData = dictData;
    [filterModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"cvaluemodels" : @"filterModel",
                 };
    }];
    _categorys = [filterModel mj_objectArrayWithKeyValuesArray:dictData[@"filters"]];
    [self.tableView reloadData];
}

//-(void)setCategorys:(NSMutableArray *)categorys
//{
//    _categorys = categorys;
//    
//    [self.tableView reloadData];
//}

//头部导航栏
-(void)setupHeaderNavigation
{
    UIView * view = [[UIView alloc] init];
    view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0,self.frame.size.width, 64);
    view.backgroundColor = [UIColor whiteColor];
    self.headerView = view;
    [self addSubview:view];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    view.frame = CGRectMake(0, 0, self.frame.size.width, 64);
    [UIView commitAnimations];
    
    //确定按钮
    UIButton * btnOK = [[UIButton alloc] init];
    btnOK.frame = CGRectMake(view.frame.size.width-50, 20, 50, 30);
    [btnOK setTitle:@"确定" forState:UIControlStateNormal];
    [btnOK setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btnOK addTarget:self action:@selector(btnOKClick) forControlEvents:UIControlEventTouchUpInside];
    btnOK.titleLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:btnOK];
    //取消按钮
    UIButton * btnCancel = [[UIButton alloc] init];
    btnCancel.frame = CGRectMake(0, 20, 50, 30);
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(btnCancelClick) forControlEvents:UIControlEventTouchUpInside];
    btnCancel.titleLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:btnCancel];
    //标题
    UILabel * lblTitle = [[UILabel alloc] init];
    lblTitle.bounds = CGRectMake(0, 0, 70, 30);
    lblTitle.center = CGPointMake(([UIScreen mainScreen].bounds.size.width)/2, btnCancel.center.y);
    lblTitle.text = @"筛选";
    lblTitle.font = [UIFont systemFontOfSize:16];
    [view addSubview:lblTitle];
    //分割线
    UIView * lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, 60, 1000, 1);
    lineView.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:lineView];
    

    
}
-(void)btnOKClick
{
    for (NSString * cid in [self.allFilters allKeys]) {
        if ([self.allFilters[cid] isEqual:@""]||[self.allFilters[cid] isEqual:@"0"]||cid==nil) {
            [self.allFilters removeObjectForKey:cid];
            continue;
        }
        NSArray * tempArr = [self.allFilters objectForKey:cid];
        if (tempArr.count==0) {
            [self.allFilters removeObjectForKey:cid];
        }
        for (filterModel * m in tempArr) {
            if ([m.cid isEqual:@"0"]) {
                [self.allFilters removeObjectForKey:cid];
                break;
            }
        }
    }
    
    
    [self.delegate YWFilterPickerFinishedPickkingFilter:self.allFilters];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    //隐藏
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(screenWidth,0,0, screenHeight);
        self.coverView.frame = CGRectMake(screenWidth,0,0, screenHeight);
        
    } completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
        [self removeFromSuperview];
        
    }];
    
    
    
   
}

-(void)btnCancelClick
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    //隐藏遮盖层
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(screenWidth,0,0, screenHeight);
        self.coverView.frame = CGRectMake(screenWidth,0,0, screenHeight);
        
    } completion:^(BOOL finished) {
        [self.delegate YWFilterPickerCancelled];
        [self.coverView removeFromSuperview];
        [self removeFromSuperview];
        
    }];
    
}


//筛选条件
-(void)setupFilterTable
{
    UITableView * tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 64, self.frame.size.width, self.frame.size.height-64);
    tableView.delegate=self;
    tableView.dataSource=self;
    
    //去掉多余的分割线
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self addSubview:tableView];
    self.tableView = tableView;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    tableView.frame =CGRectMake(0, 64, self.frame.size.width, self.frame.size.height-64);
    [UIView commitAnimations];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categorys.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建cell
    fatherCell * cell = [fatherCell cellWithTableView:tableView];
    filterModel * m = self.categorys[indexPath.row];
    cell.category = m;
    //存入筛选字典的keys
    [self.allFilters setObject:@"" forKey:m.cid];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentIndex = indexPath;
    filterModel * model = self.categorys[indexPath.row];
    
    filterValueView * fv = [[filterValueView alloc] initWithFatherId:model.cid andFatherName:model.cname];
    fv.delegate =self;
    fv.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, self.frame.size.width, self.frame.size.height-64);
    fv.categorys = model.cvaluemodels;
    [self.superview addSubview:fv];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    fv.frame = self.frame;
    [UIView commitAnimations];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
//代理方法
-(void)seleteFinishedCallBack:(NSArray *)filters andFatherId:(NSString *)fatherid
{
    fatherCell * cell = [self.tableView cellForRowAtIndexPath:self.currentIndex];
    //便利字典获取选取的筛选条件
    NSString * str = @"";
    for (filterModel * m in filters) {
       str= [str stringByAppendingFormat:@"%@,",m.cname];
    }
    if (str.length>0) {
         str=[str substringToIndex:[str length]-1];
    }
    [cell chengeDetail:str];
    if([cell.lblDetail.text isEqual:@"全部"])
    {
        cell.lblDetail.textColor = [UIColor grayColor];
    }else{
        cell.lblDetail.textColor = [UIColor redColor];
    }
    [self.allFilters setObject:filters forKey:fatherid];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

+(NSDictionary *)dictWithAllFilters:(NSDictionary *)allfilters
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    for (NSString * fid in [allfilters allKeys]) {
        NSArray * arr = [allfilters objectForKey:fid];
        NSMutableArray * strArr = [NSMutableArray array];
        for (filterModel * m in arr) {
            [strArr addObject:m.cid];
        }
        [dict setObject:strArr forKey:fid];
    }
    
    return dict;
    
}

@end
