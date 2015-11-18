# YWFilterPicker
You can easily select the attributes of the list, and get the ID of the selected attributes.  
你可以轻松选择列表的属性，并且获取选择的属性id  
Use steps  
step 1:  
 添加头文件  
 Import the ficker header file "YWFilterPicker.h"   
step 2:  
 创建初始化并设置代理
 Create、initialize and set the attributes and delegate     
 示例:  
 Example:  
    YWFilterPicker * picker = [[YWFilterPicker alloc] init];
    picker.delegate = self;
    picker.dictData = [self getDictData];
    [self.view addSubview:picker];  
step 3:  
 编写代理方法 (点击确定时触发)   
 Create your delegate method.  
 -(void)YWFilterPickerFinishedPickkingFilter:(NSDictionary *)Filter;  
 
 
数据示例: 
```
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
```
