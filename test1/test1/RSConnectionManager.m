//
//  RSConnectionManager.m
//  test1
//
//  Created by 郭 輝平 on 2012/09/02.
//  Copyright (c) 2012年 郭 輝平. All rights reserved.
//

#import "RSConnectionManager.h"

@implementation RSConnectionManager

-(void)request:(NSString *)urlString{
    [self request:urlString method:nil params:nil];
}

-(void)request:(NSString *)urlString method:(NSString *)method params:(NSDictionary *)params{
    [self request:urlString method:method params:params header:nil];
}

-(void)request:(NSString *)urlString method:(NSString *)method params:(NSDictionary *)params header:(NSDictionary *)header{
    
    NSMutableURLRequest *request;
    
    //get,postとパラメータ処理
    if([method isEqualToString:@"get"]){
        if (params) {
            request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?%@",urlString,[self changeParamsToString:params]]]];

        }else{
            request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        }
    }else{
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        [request setHTTPBody:[[self changeParamsToString:params] dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPMethod:@"post"];
    }
    
    //header データ
    if(header){
        for (NSString *headerKey in [header allKeys]) {
            [request addValue:[header objectForKey:headerKey] forHTTPHeaderField:headerKey];
        }
    }
    
    NSURLResponse *response = nil;
    NSError *error;
    
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
}

-(NSString *)changeParamsToString:(NSDictionary *)params{
    
    NSString *paramsString = nil;
    
    if (params) {
        NSMutableString *paramsStringTemp =[[NSMutableString alloc]init];
        
        for (NSString *key in [params allKeys]){
            [paramsStringTemp appendString:[NSString stringWithFormat:@"%@=%@&",key,[params objectForKey:key]]];
            
            NSLog(@"%@",[NSString stringWithFormat:@"%@=%@&",key,[params objectForKey:key]]);
        }
        if(paramsStringTemp.length>0){
            paramsString = [paramsStringTemp substringToIndex:paramsStringTemp.length-1];
        }
        NSLog(@"param:%@",paramsString);
    }
    
    return paramsString;
}
@end
