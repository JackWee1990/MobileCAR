//
//  ZCViewController_GRXX.m
//  ZCXD
//
//  Created by JackWee on 14-8-9.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import "ZCViewController_GRXX.h"

@interface ZCViewController_GRXX ()

@end

@implementation ZCViewController_GRXX

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addGestureRecognizer:self.tap_clear];
    [self titleViewConfig];
    [self textNameConfig];
    [self textPWDConfig];
    [self textPWDRConfig];
    [self texPhoneNumConfig];
    [self textIDConfig];
    //NSString *pwd = [[NSUserDefaults standardUserDefaults]objectForKey:@"dr_pwd"];
    //NSLog(@"GRXX_wdl_pwd=%@",pwd);
    
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

- (IBAction)button_save_Click:(id)sender {

    
    if (([self.text_mm.text isEqual: self.text_qrmm.text])&&(![self.text_mm.text isEqual: @""])) {
        //密码判断
        [self pwdUpdate];
    }
}

- (void)textNameConfig{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 85, 30)];
    label.text = @" 姓名 :";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_xm.leftView = label;
    self.text_xm.leftViewMode = UITextFieldViewModeAlways;
    self.text_xm.text = [_infoDic objectForKey:@"dr_name"];
    self.text_xm.enabled = NO;
}

- (void)texPhoneNumConfig{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 85, 30)];
    label.text = @" 手机号码 :";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_sjhm.leftView = label;
    self.text_sjhm.leftViewMode = UITextFieldViewModeAlways;
    self.text_sjhm.text = [_infoDic objectForKey:@"dr_tel"];
    self.text_sjhm.enabled = NO;
}

- (void)textIDConfig{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 85, 30)];
    label.text = @" 身份证号码 :";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_sfzhm.leftView = label;
    self.text_sfzhm.leftViewMode = UITextFieldViewModeAlways;
    self.text_sfzhm.text = [_infoDic objectForKey:@"dr_iden"];
    self.text_sfzhm.enabled = NO;
}

- (void)textPWDConfig{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 85, 30)];
    label.text = @" 密码 :";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_mm.leftView = label;
    self.text_mm.leftViewMode = UITextFieldViewModeAlways;
    self.text_mm.text = @"";
}

- (void)textPWDRConfig{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 85, 30)];
    label.text = @" 确认密码 :";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_qrmm.leftView = label;
    self.text_qrmm.leftViewMode = UITextFieldViewModeAlways;
    self.text_qrmm.text = @"";
}

- (void)titleViewConfig{
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"个人信息"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = customLab;

}

- (IBAction)tap_clear_Click:(id)sender {
    [self.text_mm resignFirstResponder];
    [self.text_qrmm resignFirstResponder];
    [self.text_sfzhm resignFirstResponder];
    [self.text_sjhm resignFirstResponder];
    [self.text_xm resignFirstResponder];
}



- (void)pwdUpdate{
    //NSLog(@"pwdUpdate:%@",self.text_mm.text);
    HttpController *httpController = [[HttpController alloc]init];
    NSString *type = @"POST";
    NSString *info = [NSString stringWithFormat:@"dr_tel=%@&dr_pwd=%@",[_infoDic objectForKey:@"dr_tel"],self.text_mm.text];
    NSString *url = @"app/pwd/";
    NSData *resultData = [httpController httpHandleWithType:type url:url info:info];
    //NSString *resultString = [[NSString alloc]initWithData:resultDate encoding:NSUTF8StringEncoding];
    //NSLog(@"resultString = %@",resultString);
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:nil];
    id status = [resultDic objectForKey:@"status"];
    if ([status isEqualToString:@"1"]) {
        
        ZCViewController_Root *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ZCViewController_Root"];
        [self.infoDic setValue:self.text_mm.text forKey:@"dr_pwd"];
        //vc.infoDic = self.infoDic;
        //vc.isLogin = YES;
        //NSUserDefaults *userDefaults = [[NSUserDefaults standardUserDefaults]init];
        //[userDefaults setObject:self.infoDic  forKey:@"dr_pwd"];
        //NSMutableDictionary *d =[NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"dr_pwd"]];
        [[NSUserDefaults standardUserDefaults]setObject:self.text_mm.text forKey:@"dr_pwd"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.navigationController pushViewController:vc animated:true];
        //[self.navigationController popToRootViewControllerAnimated:true];
        
    }
}

@end
