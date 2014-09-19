//
//  ZCViewController_ZC_GRXX.m
//  ZCXD
//
//  Created by JackWee on 14-8-8.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import "ZCViewController_ZC_GRXX.h"

@interface ZCViewController_ZC_GRXX ()

@end

@implementation ZCViewController_ZC_GRXX

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.view setBackgroundColor:[UIColor grayColor]];
    //[self.view setBackgroundColor:[UIColor grayColor]];
    //self.view.backgroundColor

    [self.view addGestureRecognizer:self.tap_space];
    [self titleViewConfig];
    [self textIDConfig];
    [self textNameConfig];
    [self textPhoneNumConfig];
    [self textPWDConfig];
    [self textPWDRConfig];
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

- (IBAction)button_next_Click:(id)sender {
    if (//判断各属性是否为空及验证密码
    (![self.text_mm.text  isEqual: @""])&&
    (![self.text_sjhm.text  isEqual: @""])&&
    (![self.text_sfz.text  isEqual: @""])&&
    (![self.text_xm.text  isEqual: @""])&&
    ([self.text_mm.text isEqual:self.text_qrmm.text])
        )
    {
        ZCViewController_ZC_CLXX *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ZCViewController_ZC_CLXX"];
        viewController.userInfo = [[ZCUserInfo alloc]init];
        viewController.userInfo.name = self.text_xm.text;
        viewController.userInfo.telephoneNum = self.text_sjhm.text;
        viewController.userInfo.identifyID = self.text_sfz.text;
        viewController.userInfo.password = self.text_mm.text;
        //NSLog(@"%@\n%@\n%@\n%@\n",viewController.userInfo.name,viewController.userInfo.telephoneNum,viewController.userInfo.identifyID,viewController.userInfo.password);
        [self.navigationController pushViewController:viewController animated:true];
    }
}

- (void)titleViewConfig{
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"注册"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = customLab;
    //self.navigationItem.titleView = customLab;
}

- (void)textNameConfig{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 35)];
    label.text = @" 姓名 :";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_xm.leftView = label;
    self.text_xm.leftViewMode = UITextFieldViewModeAlways;
}

- (void)textPhoneNumConfig{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 35)];
    label.text = @" 手机号码 :";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_sjhm.leftView = label;
    self.text_sjhm.leftViewMode = UITextFieldViewModeAlways;
}

- (void)textIDConfig{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 35)];
    label.text = @" 身份证号码 :";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_sfz.leftView = label;
    self.text_sfz.leftViewMode = UITextFieldViewModeAlways;
}

- (void)textPWDConfig{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 35)];
    label.text = @" 密码 :";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_mm.leftView = label;
    self.text_mm.leftViewMode = UITextFieldViewModeAlways;
}

- (void)textPWDRConfig{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 35)];
    label.text = @" 确认密码 :";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    self.text_qrmm.leftView = label;
    self.text_qrmm.leftViewMode = UITextFieldViewModeAlways;
}

- (IBAction)tap_space_Click:(id)sender {
    [self.text_mm resignFirstResponder];
    [self.text_qrmm resignFirstResponder];
    [self.text_sfz resignFirstResponder];
    [self.text_sjhm resignFirstResponder];
    [self.text_xm resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated{
    //UIColor *bgColor = [[UIColor alloc]initWithWhite: 1.0 alpha: 0.95];
    //[bgColor initWithWhite: 1.0 alpha: 0.50];
    //[self.view setBackgroundColor:bgColor];
    //self.view.backgroundColor = [[UIColor alloc]initWithWhite: 1.0 alpha: 0.95];
}
@end
