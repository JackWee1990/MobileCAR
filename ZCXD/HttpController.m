//
//  HttpController.m
//  ZCXD
//
//  Created by JackWee on 14-8-27.
//  Copyright (c) 2014年 JackWee. All rights reserved.
//

#import "HttpController.h"
@interface HttpController()
@end


@implementation HttpController

- (NSData*)httpHandleWithType:(NSString*)type url:(NSString*)url info:(NSString*)info{
    NSData *responseData = nil;
    
    NSString *baseUrl = @"http://www.congyuandong.cn:8080/t/";
    NSString *resquestUrl = [baseUrl stringByAppendingString:url];
    
    NSURL *connecturl = [[NSURL alloc]initWithString:resquestUrl];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:connecturl];
    [request setHTTPMethod:type];
    if ([type isEqualToString:@"POST"]) {
        NSMutableData *postBody = [NSMutableData data];
        [postBody appendData:[info dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:postBody];
    }
    else if ([type isEqualToString:@"GET"]){
        [request setHTTPMethod:@"GET"];
    }
    
    NSHTTPURLResponse *urlResponse = [[NSHTTPURLResponse alloc]init];
    NSError *error = [[NSError alloc]init];
    responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (responseData == nil) {
        NSLog(@"error:%@",error);
        responseData = [[NSData alloc]init];
    }
    
    return responseData;
}

@end
