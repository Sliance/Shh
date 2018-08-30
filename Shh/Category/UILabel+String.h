//
//  UILabel+String.h
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/28.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (String)
/**
 设置文本,并指定行间距
 
 @param text 文本内容
 @param lineSpacing 行间距
 */
-(void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;
@end
