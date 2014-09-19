//
//  HttpController.h
//  ZCXD
//
//  Created by JackWee on 14-8-27.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpController : NSObject

//@property (strong,nonatomic) HttpDelegate *delegate;
//type:(POST/GET) url:请求API info:传递内容 返回请求内容(POST->Int,GET->JSON)
- (NSData*)httpHandleWithType:(NSString*)type url:(NSString*)url info:(NSString*)info;


@end
