//
//  ZCViewController_CLXX.m
//  ZCXD
//
//  Created by JackWee on 14-8-9.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import "ZCViewController_CLXX.h"

@interface ZCViewController_CLXX ()

@end

@implementation ZCViewController_CLXX

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addGestureRecognizer:self.tap_clear];
    [self titleViewConfig];
    [self textCarNumConfig];
    [self textHandCarNumConfig];
    [self textCarTypeConfig];
    [self textCarLengthConfig];
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

- (void)titleViewConfig{
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"车辆信息"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = customLab;
}


- (IBAction)button_save_Click:(id)sender {
    if(
       ((![self.text_cphm.text isEqual: [_infoDic objectForKey:@"dr_number"]])&&(![self.text_cphm.text isEqual:@""]))||
       ((![self.text_gchm.text isEqual: [_infoDic objectForKey:@"dr_hand"]])&&(![self.text_gchm.text isEqual:@""]))||
       ((![self.text_cllx.text isEqual: [_infoDic objectForKey:@"dr_type"]])&&(![self.text_cllx.text    isEqual:@""]))||
       ((![self.text_clcd.text isEqual: [_infoDic objectForKey:@"dr_length"]])&&(![self.text_clcd.text    isEqual:@""]))||
       ((![self.text_zdzz.text isEqual: [_infoDic objectForKey:@"dr_weight"]])&&(![self.text_zdzz.text    isEqual:@""]))
       )
    {//车辆信息判断
        [self carInfoUpdate];
    }
}

- (void)textCarNumConfig{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 105, 30)];
    label.text = @" 车牌号码 :";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_cphm.leftView = label;
    self.text_cphm.leftViewMode = UITextFieldViewModeAlways;
    self.text_cphm.text = [_infoDic objectForKey:@"dr_number"];
}

- (void)textHandCarNumConfig{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 105, 30)];
    label.text = @" 挂车号码 :";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_gchm.leftView = label;
    self.text_gchm.leftViewMode = UITextFieldViewModeAlways;
    self.text_gchm.text = [_infoDic objectForKey:@"dr_hand"];
}

- (void)textCarTypeConfig{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 105, 30)];
    label.text = @" 车辆类型 :";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_cllx.leftView = label;
    self.text_cllx.leftViewMode = UITextFieldViewModeAlways;
    self.text_cllx.text = [_infoDic objectForKey:@"dr_type"];
}

- (void)textCarLengthConfig{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 105, 30)];
    label.text = @" 车辆长度 (米) :";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_clcd.leftView = label;
    self.text_clcd.leftViewMode = UITextFieldViewModeAlways;
    self.text_clcd.text = [_infoDic objectForKey:@"dr_length"];
}

- (void)textMaxWeightConfig{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 105, 30)];
    label.text = @" 最大载重 (吨):";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_zdzz.leftView = label;
    self.text_zdzz.leftViewMode = UITextFieldViewModeAlways;
    self.text_zdzz.text = [_infoDic objectForKey:@"dr_weight"];
}

- (void)carInfoUpdate{
    //NSLog(@"carInfoUpdate");
    HttpController *httpController = [[HttpController alloc]init];
    NSString *type = @"POST";
    NSString *info = [NSString stringWithFormat:@"dr_tel=%@&dr_number=%@&dr_hand=%@&dr_type=%@&dr_length=%@&dr_weight=%@",[_infoDic objectForKey:@"dr_tel"],self.text_cphm.text,self.text_gchm.text,self.text_cllx.text,self.text_clcd.text,self.text_zdzz.text];
    NSString *url = @"app/update/";
    NSData *resultData = [httpController httpHandleWithType:type url:url info:info];
    //NSString *resultString = [[NSString alloc]initWithData:resultDate encoding:NSUTF8StringEncoding];
    //NSLog(@"resultString = %@",resultString);
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:nil];
    id status = [resultDic objectForKey:@"status"];
    if ([status isEqualToString:@"1"]) {
        
        ZCViewController_Root *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ZCViewController_Root"];
        [self.infoDic setValue:self.text_cphm.text forKey:@"dr_number"];
        [self.infoDic setValue:self.text_gchm.text forKey:@"dr_hand"];
        [self.infoDic setValue:self.text_cllx.text forKey:@"dr_type"];
        [self.infoDic setValue:self.text_clcd.text forKey:@"dr_length"];
        [self.infoDic setValue:self.text_zdzz.text forKey:@"dr_weight"];
        //vc.infoDic = self.infoDic;
        //vc.isLogin = YES;
        //NSUserDefaults *userDefault = [[NSUserDefaults standardUserDefaults]init];
        //[userDefault setObject:self.infoDic forKey:@"infoDic"];
        //[userDefault synchronize];
        //NSLog(@"ZCViewController_CLXX_carInfoUpdate_before");
        /*
         
         那么，要保存的时候，我们只能这样做了：
         
         1、从NSUserDefaults读取出来
         
         2、生成一个可变数组，修改值
         
         3、将新的数组重新保存到NSUserDefaults中
         
        NSDictionary *nd = [[NSUserDefaults standardUserDefaults]objectForKey:@"infoDic"];
        NSMutableDictionary *md = [[NSMutableDictionary alloc]initWithCapacity:9];
        md = [NSMutableDictionary dictionaryWithDictionary:nd];
        [md setValue:self.text_cphm.text forKey:@"dr_number"];
        [md setValue:self.text_gchm.text forKey:@"dr_hand"];
        [md setValue:self.text_cllx.text forKey:@"dr_type"];
        [md setValue:self.text_clcd.text forKey:@"dr_length"];
        [md setValue:self.text_zdzz.text forKey:@"dr_weight"];
        [[NSUserDefaults standardUserDefaults]setObject:md forKey:@"infoDic"];
        */
        
        [self.navigationController pushViewController:vc animated:true];
        //NSLog(@"ZCViewController_CLXX_carInfoUpdate_after");
    }
}

- (IBAction)tap_clear_Click:(id)sender {
    [self.text_clcd resignFirstResponder];
    [self.text_cllx resignFirstResponder];
    [self.text_cphm resignFirstResponder];
    [self.text_gchm resignFirstResponder];
    [self.text_zdzz resignFirstResponder];
    //self.tv.hidden = YES;
}

- (IBAction)button_showtv_Click:(id)sender {
    //self.tv.hidden = NO;
    if (self.tv.hidden == NO) {
        self.tv.hidden = YES;
        [self.view addGestureRecognizer:self.tap_clear];
    }
    else{
        self.tv.hidden = NO;
        [self.view removeGestureRecognizer:self.tap_clear];
    }
}

- (void)getTruckTypeFromServer{
    NSData *resultData = nil;
    HttpController *httpController = [[HttpController alloc]init];
    
    NSString *type = @"GET";
    NSString *url = [NSString stringWithFormat:@"app/truck_type/"];
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
    [self.view addGestureRecognizer:self.tap_clear];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.truckTypeArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"CLXX_cellForRowAtIndexPath");
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
