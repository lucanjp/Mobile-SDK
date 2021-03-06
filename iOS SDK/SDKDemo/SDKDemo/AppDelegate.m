//
//  AppDelegate.m
//  SDKDemo
//
//  Created by MarcusWoo on 2018/9/6.
//  Copyright © 2018 TokenPocket. All rights reserved.
//

#import "AppDelegate.h"
#import <TPSDK/TPSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [TPApi registerAppID:@"demoapp"];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    [TPApi handleURL:url options:options result:^(TPRespObj *respObj) {
        
        NSString *title = @"Success";
        if (respObj.result == TPRespResultFailure) {
            title = @"Failure";
        } else if (respObj.result == TPRespResultCanceled) {
            title = @"Cancel";
        }
        NSString *JSONString = [self JSONString:respObj.data];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:JSONString preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
    }];
    
    return YES;
}

- (NSString *)JSONString:(id)obj {
    if ([NSJSONSerialization isValidJSONObject:obj]) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
        if (data) {
            return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }
    }
    return nil;
}

@end
