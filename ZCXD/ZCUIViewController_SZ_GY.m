//
//  ZCUIViewController_SZ_GY.m
//  ZCXD
//
//  Created by JackWee on 14-9-11.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import "ZCUIViewController_SZ_GY.h"

@interface ZCUIViewController_SZ_GY ()

@end

@implementation ZCUIViewController_SZ_GY

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
    [self navigationConfig];
    // Do any additional setup after loading the view.
    UIImage *image = [UIImage imageNamed:@"logo.png"];
    self.iv.image = image;
    
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
- (void)navigationConfig{
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"关于"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = customLab;
}
@end
