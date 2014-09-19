//
//  ZCUIViewController_SZ_YJFK.h
//  ZCXD
//
//  Created by JackWee on 14-9-1.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCUIViewController_SZ_YJFK : UIViewController
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tap_clear;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIButton *button_submit;
- (IBAction)button_submit_Click:(id)sender;
- (IBAction)tap_clear_Click:(id)sender;
- (void)navigationConfig;
@end
