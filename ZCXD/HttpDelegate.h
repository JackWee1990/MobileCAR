//
//  HttpDelegate.h
//  ZCXD
//
//  Created by JackWee on 14-8-27.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import <Foundation/Foundation.h>
//2个可选型函数 分别处理POST回来的Int及Get回来的JSON
@protocol HttpDelegate <NSObject>

@optional

- (void)handlePostResult:(int)postResult;
- (void)handleGetResult:(NSArray)getResult;
@end
