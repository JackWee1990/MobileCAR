//
//  ZCUIViewController_SZ_YJFK.m
//  ZCXD
//
//  Created by JackWee on 14-9-1.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import "ZCUIViewController_SZ_YJFK.h"

@interface ZCUIViewController_SZ_YJFK ()

@end

@implementation ZCUIViewController_SZ_YJFK

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addGestureRecognizer:self.tap_clear];
    [self navigationConfig];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)button_submit_Click:(id)sender {
}

- (IBAction)tap_clear_Click:(id)sender {
    [self.textView resignFirstResponder];
}

- (void)navigationConfig{
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"意见反馈"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = customLab;
}
@end
