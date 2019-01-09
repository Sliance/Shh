//
//  AppDelegate.m
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/23.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"
#import "ZSNotification.h"
#import <AlipaySDK/AlipaySDK.h>
@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _mainTabController = [[ShhTabBarController alloc] init];
    self.window.rootViewController = _mainTabController;
    [self.window makeKeyAndVisible];
     [WXApi registerApp:@"wx16213987534b352b"];
    return YES;
}
#pragma MARK - aliPay

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    
    if ([url.host isEqualToString:@"safepay"]) {
//         支付跳转支付宝钱包进行支付，处理支付结果
                [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                    NSLog(@"result = %@",resultDic);
        
                }];
        
//         授权跳转支付宝钱包进行支付，处理支付结果
                [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
                    NSLog(@"result = %@",resultDic);
                    // 解析 auth code
                    NSString *result = resultDic[@"result"];
                    NSString *authCode = nil;
                    if (result.length>0) {
                        NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                        for (NSString *subResult in resultArr) {
                            if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                                authCode = [subResult substringFromIndex:10];
                                break;
                            }
                        }
                    }
                    NSLog(@"授权结果 authCode = %@", authCode?:@"");
                }];
        
    }
    return YES;
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    
    if ([url.host isEqualToString:@"pay"]) {//微信支付
        [WXApi handleOpenURL:url delegate:self];
    }
    if ([url.host isEqualToString:@"oauth"]) {//微信登录
        [WXApi handleOpenURL:url delegate:self];
    }
    if ([url.host isEqualToString:@"safepay"]) {
//         支付跳转支付宝钱包进行支付，处理支付结果
                [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                    NSLog(@"result = %@",resultDic);
                    if ([resultDic[@"resultStatus"] integerValue] ==9000) {
                        [ZSNotification postAlipayPayResultNotification:@{@"strMsg":@"支付成功"}];
                    }else{
                        [ZSNotification postAlipayPayResultNotification:@{@"strMsg":resultDic[@"memo"]}];
                    }
        
                }];
        
//         授权跳转支付宝钱包进行支付，处理支付结果
                [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
                    NSLog(@"result = %@",resultDic);
                    // 解析 auth code
                    NSString *result = resultDic[@"result"];
                    NSString *authCode = nil;
                    if (result.length>0) {
                        NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                        for (NSString *subResult in resultArr) {
                            if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                                authCode = [subResult substringFromIndex:10];
                                break;
                            }
                        }
                    }
                    NSLog(@"授权结果 authCode = %@", authCode?:@"");
                }];
    }
    
    
    return YES;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    return [WXApi handleOpenURL:url delegate:self];
}
//微信代理方法
- (void)onResp:(BaseResp *)resp
{
    
    
    
    
    
    NSString * strMsg = [NSString stringWithFormat:@"errorCode: %d",resp.errCode];
    NSLog(@"strMsg: %@",strMsg);
    
    NSString * errStr       = [NSString stringWithFormat:@"errStr: %@",resp.errStr];
    NSLog(@"errStr: %@",errStr);
    NSString * strTitle;
    //判断是微信消息的回调 --> 是支付回调回来的还是消息回调回来的.
    if ([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息的结果"];
    }
    
    NSString * wxPayResult;
    //判断是否是微信支付回调 (注意是PayResp 而不是PayReq)
    
    if ([resp isKindOfClass:[PayResp class]])
    {
        //支付返回的结果, 实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        switch (resp.errCode)
        {
            case WXSuccess:
            {
                strMsg = @"支付成功";
                NSLog(@"支付成功: %d",resp.errCode);
                wxPayResult = @"success";
                
                break;
            }
            case WXErrCodeUserCancel:
            {
                strMsg = @"用户取消了支付";
                NSLog(@"用户取消支付: %d",resp.errCode);
                wxPayResult = @"cancel";
                break;
            }
            default:
            {
                strMsg =  @"支付失败";//[NSString stringWithFormat:@"支付失败! code: %d  errorStr: %@",resp.errCode,resp.errStr];
                NSLog(@":支付失败: code: %d str: %@",resp.errCode,resp.errStr);
                wxPayResult = @"faile";
                break;
            }
        }
        [ZSNotification postWeixinPayResultNotification:@{@"weixinpay": wxPayResult,@"strMsg":strMsg}];
        
        
    }
    if([resp isKindOfClass:[SendAuthResp class]]){
        
        SendAuthResp *aresp = (SendAuthResp *)resp;
        if(aresp.errCode== 0)
        {
            NSString *code = aresp.code;
//            [self getWeiXinOpenId:code];
        }
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
