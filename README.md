# YWFilterPicker
You can easily select the attributes of the list, and get the ID of the selected attributes.  
你可以轻松选择列表的属性，并且获取选择的属性id  
Use steps  
step 1:  
 添加头文件  
 Import the ficker header file "YWFilterPicker.h" and the model file "filterModel.h"  
step 2:  
 创建初始化并设置属性、代理   
 Create、initialize and set the attributes and delegate   
 --The x of frame is temporarily fixed to 50 in current version.  
 示例:  
 Example:  
 YWFilterPicker * picker = [[YWFilterPicker alloc] init];  
 picker.delegate = self;  
 picker.categorys = [self getData];  
 [self.view addSubview:picker];  
 
step 3:  
 编写代理方法 (点击确定时触发)   
 Create your delegate method.  
 -(void)YWFilterPickerFinishedPickkingFilter:(NSDictionary *)Filter;  
  
