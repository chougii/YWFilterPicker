//
//  filterValieView.m
//  YWFilterPicker
//
//  Created by ChouGii on 15/9/18.
//  Copyright (c) 2015年 zyw. All rights reserved.
//

#import "filterValueView.h"
#import "filterModel.h"
#import "MJExtension.h"
#import "categoryCell.h"

@interface filterValueView()<UITableViewDataSource,UITableViewDelegate>{
    CGRect screenBounds;
}

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,weak) UIButton * btnOK;

@property (nonatomic,copy,readwrite) NSString * categoryName;
@end

@implementation filterValueView


-(instancetype)initWithFatherId:(NSString *)fatherId andFatherName:(NSString *)fathername
{
    if (self=[super init]) {
        screenBounds = [UIScreen mainScreen].bounds;
        self.fatherId = fatherId;
        self.filters = [NSMutableArray array];
        _categorys = [NSMutableArray array];
        self.categoryName = fathername;
    }
    return self;
}

-(void)layoutSubviews
{
    [self setupHeaderNavigation];
    [self setupTableView];
}

-(void)setupTableView
{
    
    UITableView * tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, 64, self.frame.size.width, self.frame.size.height);
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //去掉多余的分割线
    tableView.tableFooterView = [[UIView alloc] init];
    self.tableView = tableView;
    [self addSubview:tableView];
}
//头部导航栏
-(void)setupHeaderNavigation
{
    UIView * view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, self.frame.size.width, 64);
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    
    //确定按钮
    UIButton * btnOK = [[UIButton alloc] init];
    btnOK.frame = CGRectMake(view.frame.size.width-50, 20, 50, 30);
    [btnOK setTitle:@"确定" forState:UIControlStateNormal];
    btnOK.titleLabel.font = [UIFont systemFontOfSize:14];
    [btnOK setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btnOK addTarget:self action:@selector(btnOKClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnOK];
    //取消按钮
    UIButton * btnCancel = [[UIButton alloc] init];
    btnCancel.frame = CGRectMake(0, 20, 50, 30);
    [btnCancel setTitle:@"返回" forState:UIControlStateNormal];
    btnCancel.titleLabel.font = [UIFont systemFontOfSize:14];
    [btnCancel setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(btnCancelClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnCancel];
    //标题
    UILabel * lblTitle = [[UILabel alloc] init];
    CGFloat  titleWidth = [UIScreen mainScreen].bounds.size.width - 150;
    lblTitle.frame = CGRectMake(btnOK.frame.size.width, 20, titleWidth, 30);
    lblTitle.text = _categoryName;

    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.textColor = [UIColor blackColor];
    lblTitle.font = [UIFont systemFontOfSize:16];
    [view addSubview:lblTitle];
    //分割线
    UIView * lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, 60, 1000, 1);
    lineView.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:lineView];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(void)btnOKClick
{
    if (self.filters.count==0) {
        filterModel * m = [[filterModel alloc] init];
        m.cid = @"0";
        m.cname = @"全部";
        m.cvaluemodels = [NSMutableArray array];
        [self.filters addObject:m];
    }
    
    [self.delegate seleteFinishedCallBack:self.filters andFatherId:self.fatherId];
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(screenBounds.size.width, 0, 0, screenBounds.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

-(void)btnCancelClick
{
    [self.delegate seleteFinishedCallBack:self.filters andFatherId:self.fatherId];
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(screenBounds.size.width, 0, 0, screenBounds.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)setCategorys:(NSMutableArray *)categorys
{
    _categorys =  categorys;
    
    int temp = 0;
    filterModel * ff = categorys[0];
    for (filterModel * fm in _categorys) {
        if ([fm.cid isEqual:@"0"]) {
            temp = 1;
        }
    }
    if (!temp) {
        filterModel * m = [[filterModel alloc] init];
        m.cid= @"0";
        m.cname=@"全部";
        [_categorys insertObject:m atIndex:0];
    }
    
    [self.tableView reloadData];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categorys.count;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    categoryCell * cell = [categoryCell cellWithTableView:tableView];
    
    cell.category = self.categorys[indexPath.row];
   
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    categoryCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.category.cid isEqual:@"0"]) {
        for (int i =0; i<self.categorys.count; i++) {
            categoryCell * c = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            if (![c.category.cid isEqual:@"0"]) {
                [c hideRightButton];
                [self.filters removeObject:c.category];
            }
        }
        [cell showRightButton];
        [self.filters addObject:cell.category];
    }else{
        categoryCell * c = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [c hideRightButton];
        [self.filters removeObject:c.category];
        
        if (cell.isShowing) {
            [cell hideRightButton];
            [self.filters removeObject:cell.category];
        }else{
            [cell showRightButton];
            [self.filters addObject:cell.category];
        }
    }
    
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
@end
