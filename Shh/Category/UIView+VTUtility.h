//
//  UIView+VTUtility.h
//  DnaerApp
//
//  Created by love on 2018/9/26.
//  Copyright © 2018年 love. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, UIBorderSideType) {
    UIBorderSideTypeAll  = 0,
    UIBorderSideTypeTop = 1 << 0,
    UIBorderSideTypeBottom = 1 << 1,
    UIBorderSideTypeLeft = 1 << 2,
    UIBorderSideTypeRight = 1 << 3,
};

@interface UIView (VTUtility)

#pragma mark - 圆角
/*! 圆形遮罩层 一般用于头像 */
- (void)addMaskLayer;
- (void)addMaskLayerRasterize;

/*! 设置圆角 左右四个角都可以单独或组合设置 */
- (void)setCorner:(UIRectCorner)corners radius:(float)radius;

/*! layer设置圆角 */
- (void)setRoundRadius:(float)radius borderColor:(UIColor *)bColor;
- (void)setRoundRadius:(float)radius borderColor:(UIColor *)bColor board:(CGFloat)board;
- (void)setResterizeRoundRadius:(float)radius borderColor:(UIColor *)bColor;

/*! 部分圆角 */
- (UIView *)borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(UIBorderSideType)borderType;

#pragma mark - 基础方法
- (void)setVt_x:(CGFloat)vt_x;
- (CGFloat)vt_x;
- (void)setVt_y:(CGFloat)vt_y;
- (CGFloat)vt_y;
- (void)setVt_w:(CGFloat)vt_w;
- (CGFloat)vt_w;
- (void)setVt_h:(CGFloat)vt_h;
- (CGFloat)vt_h;
- (void)setVt_size:(CGSize)vt_size;
- (CGSize)vt_size;
- (void)setVt_origin:(CGPoint)vt_origin;
- (CGPoint)vt_origin;

#pragma mark - layer
// 添加 渐变层
- (CAGradientLayer *)createGradientStartColor:(UIColor *)color1 endColor:(UIColor *)color2;
- (void)addGradientStartColor:(UIColor *)color1 endColor:(UIColor *)color2;
- (NSAttributedString *)getAttributeWith:(id)sender
                                  string:(NSString *)string
                               orginFont:(CGFloat)orginFont
                              orginColor:(UIColor *)orginColor
                           attributeFont:(CGFloat)attributeFont
                          attributeColor:(UIColor *)attributeColor;
@end
