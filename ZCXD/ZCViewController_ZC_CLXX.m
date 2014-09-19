//
//  ZCViewController_ZC_CLXX.m
//  ZCXD
//
//  Created by JackWee on 14-8-8.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import "ZCViewController_ZC_CLXX.h"

@interface ZCViewController_ZC_CLXX ()

@end

@implementation ZCViewController_ZC_CLXX

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSLog(@"%@\n%@\n%@\n%@\n",self.userInfo.name,self.userInfo.telephoneNum,self.userInfo.identifyID,self.userInfo.password);
    [self.view addGestureRecognizer:self.tap_space];
    [self titleViewConfig];
    [self textCarLengthConfig];
    [self textCarNumConfig];
    [self textCarTypeConfig];
    [self textHandCarNumConfig];
    [self textMaxWeightConfig];
    [self getTruckTypeFromServer];
    [self tvConfig];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)button_submit_Click:(id)sender {
    if (//判断各属性是否为空及验证密码
        (![self.text_clcd.text  isEqual: @""])&&
        (![self.text_cllx.text  isEqual: @""])&&
        (![self.text_cphm.text  isEqual: @""])&&
        (![self.text_gchm.text  isEqual: @""])&&
        (![self.text_zdzc.text  isEqual: @""])
        )
    {
        self.userInfo.carNum = self.text_cphm.text;
        self.userInfo.handcarNum = self.text_gchm.text;
        self.userInfo.carType = self.text_cllx.text;
        self.userInfo.carLength = self.text_clcd.text;
        self.userInfo.maxWeight = self.text_zdzc.text;
        //NSLog(@"%@\n%@\n%@\n%@\n",viewController.userInfo.name,viewController.userInfo.telephoneNum,viewController.userInfo.identifyID,viewController.userInfo.password);
        //[self.navigationController pushViewController:viewController animated:true];
        ///////////////////////////
        //[self submitInfoToServer];
        ///////////////////////////
        //UIViewController *dlViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ZCViewController_DL"];
        //[self presentViewController:dlViewController animated:true completion:nil];
        //[self.navigationController popToRootViewControllerAnimated:true];
        
        HttpController *httpCpntroller = [[HttpController alloc]init];
        NSString *type = @"POST";
        NSString *url = [NSString stringWithFormat:@"app/reg/"];
        NSString *info = [NSString stringWithFormat:@"dr_name=%@&dr_iden=%@&dr_tel=%@&dr_number=%@&dr_hand=%@&dr_type=%@&dr_length=%@&dr_weight=%@&dr_pwd=%@",self.userInfo.name,self.userInfo.identifyID,self.userInfo.telephoneNum,self.userInfo.carNum,self.userInfo.handcarNum,self.userInfo.carType,self.userInfo.carLength,self.userInfo.maxWeight,self.userInfo.password];
        [httpCpntroller httpHandleWithType:type url:url info:info];
        //NSData *reponseData = [httpCpntroller httpHandleWithType:type url:url info:info];
        //NSLog(@"%@",reponseData);
        ZCViewController_DL *vc = [self.storyboard instantiateViewControllerWithIdentifier: @"ZCViewController_DL"];
        [self.navigationController pushViewController:vc animated:true];
    }
}

- (IBAction)button_showtv_Click:(id)sender {
    if (self.tv.hidden == NO) {
        self.tv.hidden = YES;
        [self.view addGestureRecognizer:self.tap_space];
    }
    else{
        self.tv.hidden = NO;
        [self.view removeGestureRecognizer:self.tap_space];
    }
}
- (void)submitInfoToServer {
    //NSLog(@"111");
    //1、  准备阶段
    
    //NSString *urlString = [NSString stringWithFormat:@"http://115.28.107.151:8082/t/driver_reg/"];
    NSString *urlString = [NSString stringWithFormat:@"http://115.28.107.151:8082/t/app/reg/"];
    /*
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    [request setURL:[NSURL URLWithString:urlString]];
    
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:5];
    */
    NSURL *url = [[NSURL alloc]initWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5];
    [request setHTTPMethod:@"POST"];
    //2、设置头
    /*
    NSString *contentType = [NSString stringWithFormat:@"text/xml"];
    
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    */
    
    
    
    
    //3、数据内容体的设定
    
    NSMutableData *postBody = [NSMutableData data];
    /*
    [postBody appendData:[[NSString stringWithFormat:@"dr_name=%@&dr_iden=%@&dr_tel=%@dr_number=%@&dr_hand=%@&dr_type=%@dr_length=%@&dr_weight=%@&dr_pwd=%@",self.userInfo.name,self.userInfo.identifyID,self.userInfo.telephoneNum,self.userInfo.carNum,self.userInfo.handcarNum,self.userInfo.carType,self.userInfo.carLength,self.userInfo.maxWeight,self.userInfo.password] dataUsingEncoding:NSUTF8StringEncoding]];
     */
    [postBody appendData:[[NSString stringWithFormat:@"dr_name=%@&dr_iden=%@&dr_tel=%@&dr_number=%@&dr_hand=%@&dr_type=%@&dr_length=%@&dr_weight=%@&dr_pwd=%@",self.userInfo.name,self.userInfo.identifyID,self.userInfo.telephoneNum,self.userInfo.carNum,self.userInfo.handcarNum,self.userInfo.carType,self.userInfo.carLength,self.userInfo.maxWeight,self.userInfo.password] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:postBody];
    /*
    dr_name = forms.CharField(label='姓名：')
    dr_iden =  forms.CharField(label='身份证号码：')
    dr_tel = forms.CharField(label='手机号码：')
    dr_number = forms.CharField(label='车牌号码：')
    dr_hand = forms.CharField(label='挂车号码：')
    dr_type = forms.CharField(label='车辆类型：')
    dr_length = forms.CharField(label='车辆长度：')
    dr_weight = forms.CharField(label='最大载重：')
    dr_pwd = forms.CharField(label='设置密码：')*/
    //4、请求响应
    //NSLog(@"%@\n",request.HTTPBody);
    NSHTTPURLResponse* urlResponse = nil;
    
    NSError *error = [[NSError alloc] init];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    //NSLog(@"%ld\n",(long)urlResponse.statusCode);
    NSLog(@"%@",responseData);
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",result);

    if ([result isEqual:nil]) {
        NSLog(@"Error: domain = %@, code = %ld, dict = %ld", error.domain, (long) error.code, (long) [error.userInfo count]);
        for (id key in error.userInfo) {
            NSLog(@"key: %@, value: %@", key, [error.userInfo objectForKey:key]);
        }
    }
    //[self.navigationController popToRootViewControllerAnimated:true];
    //UIViewController *dlViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ZCViewController_DL"];
    //[self presentViewController:dlViewController animated:true completion:nil];
}

- (void)titleViewConfig{
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"注册"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = customLab;
}

- (void)textCarNumConfig{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 35)];
    label.text = @" 车牌号码 :";
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_cphm.leftView = label;
    self.text_cphm.leftViewMode = UITextFieldViewModeAlways;
}

- (void)textHandCarNumConfig{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 35)];
    label.text = @" 挂车号码 :";
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_gchm.leftView = label;
    self.text_gchm.leftViewMode = UITextFieldViewModeAlways;
}

- (void)textCarTypeConfig{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 35)];
    label.text = @" 车辆类型 :";
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_cllx.leftView = label;
    self.text_cllx.leftViewMode = UITextFieldViewModeAlways;
}

- (void)textCarLengthConfig{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 35)];
    label.text = @" 车辆长度（米） :";
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_clcd.leftView = label;
    self.text_clcd.leftViewMode = UITextFieldViewModeAlways;
}

- (void)textMaxWeightConfig{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 35)];
    label.text = @" 最大载重（吨） :";
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_zdzc.leftView = label;
    self.text_zdzc.leftViewMode = UITextFieldViewModeAlways;
}

- (IBAction)tap_space_Click:(id)sender {
    [self.text_clcd resignFirstResponder];
    [self.text_cllx resignFirstResponder];
    [self.text_cphm resignFirstResponder];
    [self.text_gchm resignFirstResponder];
    [self.text_zdzc resignFirstResponder];
}

- (void)getTruckTypeFromServer{
    NSData *resultData = nil;
    HttpController *httpController = [[HttpController alloc]init];
    
    NSString *type = @"GET";
    NSString *url = [NSString stringWithFormat:@"http://115.28.107.151:8082/t/app/truck_type/"];
    NSString *info = @"nil";
    
    resultData = [httpController httpHandleWithType:type url:url info:info];
    NSString *resultString = [[NSString alloc]initWithData:resultData encoding:NSUTF8StringEncoding];
    //NSLog(@"ZCViewController_CLXX_getTruckTypeFromServer_resultString = %@",resultString);
    self.truckTypeArray = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:nil];
}


- (void)tvConfig{
    self.tv.dataSource = self;
    self.tv.delegate = self;
    self.tv.hidden = YES;
    
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"ZCViewController_CLXX_didSelectRowAtIndexPath_indexPath=%ld",(long)indexPath.row);
    
    NSDictionary *cellDic = [self.truckTypeArray objectAtIndex:indexPath.row];
    
    self.text_cllx.text = [cellDic objectForKey:@"type"];
    self.tv.hidden = YES;
    [self.view addGestureRecognizer:self.tap_space];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.truckTypeArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    NSDictionary *cellDic = [self.truckTypeArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [cellDic objectForKey:@"type"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}

@end


