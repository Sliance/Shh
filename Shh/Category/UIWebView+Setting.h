//
//  UIWebView+Setting.h
//  Shh
//
//  Created by zhangshu on 2019/1/9.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWebView (Setting)
-(NSMutableAttributedString *)setAttributedString:(NSString *)str;
-(CGFloat )getHTMLHeightByStr:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
