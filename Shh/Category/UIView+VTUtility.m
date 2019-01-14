//
//  UIView+VTUtility.m
//  DnaerApp
//
//  Created by love on 2018/9/26.
//  Copyright © 2018年 love. All rights reserved.
//

#import "UIView+VTUtility.h"

@implementation UIView (VTUtility)

#pragma mark - 圆角
- (void)addMaskLayer {
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor blackColor].CGColor;
    maskLayer.strokeColor = [UIColor clearColor].CGColor;
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
}

- (void)addMaskLayerRasterize {
    [self addMaskLayer];
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)setCorner:(UIRectCorner)corners radius:(float)radius {
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:corners
                                           cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)setRoundRadius:(float)radius borderColor:(UIColor *)bColor {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [bColor CGColor];
}

- (void)setRoundRadius:(float)radius borderColor:(UIColor *)bColor board:(CGFloat)board {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
    self.layer.borderWidth = board;
    self.layer.borderColor = [bColor CGColor];
}

- (void)setResterizeRoundRadius:(float)radius borderColor:(UIColor *)bColor {
    [self setRoundRadius:radius borderColor:bColor];
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (UIView *)borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(UIBorderSideType)borderType {
    if (borderType == UIBorderSideTypeAll) {
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = color.CGColor;
        return self;
    }
    
    
    /// 左侧
    if (borderType & UIBorderSideTypeLeft) {
        /// 左侧线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.f, 0.f) toPoint:CGPointMake(0.0f, self.frame.size.height) color:color borderWidth:borderWidth]];
    }
    
    /// 右侧
    if (borderType & UIBorderSideTypeRight) {
        /// 右侧线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(self.frame.size.width, 0.0f) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height) color:color borderWidth:borderWidth]];
    }
    
    /// top
    if (borderType & UIBorderSideTypeTop) {
        /// top线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.0f, 0.0f) toPoint:CGPointMake(self.frame.size.width, 0.0f) color:color borderWidth:borderWidth]];
    }
    
    /// bottom
    if (borderType & UIBorderSideTypeBottom) {
        /// bottom线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.0f, self.frame.size.height) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height) color:color borderWidth:borderWidth]];
    }
    
    return self;
}

- (CAShapeLayer *)addLineOriginPoint:(CGPoint)p0 toPoint:(CGPoint)p1 color:(UIColor *)color borderWidth:(CGFloat)borderWidth {
    /// 线的路径
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:p0];
    [bezierPath addLineToPoint:p1];
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor  = [UIColor clearColor].CGColor;
    /// 添加路径
    shapeLayer.path = bezierPath.CGPath;
    /// 线宽度
    shapeLayer.lineWidth = borderWidth;
    return shapeLayer;
}

#pragma mark - 基础方法
- (void)setVt_x:(CGFloat)vt_x {
    CGRect frame = self.frame;
    frame.origin.x = vt_x;
    self.frame = frame;
}

- (CGFloat)vt_x {
    return self.frame.origin.x;
}

- (void)setVt_y:(CGFloat)vt_y {
    CGRect frame = self.frame;
    frame.origin.y = vt_y;
    self.frame = frame;
}

- (CGFloat)vt_y {
    return self.frame.origin.y;
}

- (void)setVt_w:(CGFloat)vt_w {
    CGRect frame = self.frame;
    frame.size.width = vt_w;
    self.frame = frame;
}

- (CGFloat)vt_w {
    return self.frame.size.width;
}

- (void)setVt_h:(CGFloat)vt_h {
    CGRect frame = self.frame;
    frame.size.height = vt_h;
    self.frame = frame;
}

- (CGFloat)vt_h {
    return self.frame.size.height;
}

- (void)setVt_size:(CGSize)vt_size {
    CGRect frame = self.frame;
    frame.size = vt_size;
    self.frame = frame;
}

- (CGSize)vt_size {
    return self.frame.size;
}

- (void)setVt_origin:(CGPoint)vt_origin {
    CGRect frame = self.frame;
    frame.origin = vt_origin;
    self.frame = frame;
}

- (CGPoint)vt_origin {
    return self.frame.origin;
}

#pragma mark - layer
- (CAGradientLayer *)createGradientStartColor:(UIColor *)color1 endColor:(UIColor *)color2 {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.colors = @[(id)color1.CGColor,
                             (id)color2.CGColor];
    // 根据起点指向终点的方向来渐变颜色,范围是0～1
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    return gradientLayer;
}

- (void)addGradientStartColor:(UIColor *)color1 endColor:(UIColor *)color2 {
    CAGradientLayer *layer = [self createGradientStartColor:color1 endColor:color2];
    [self.layer addSublayer:layer];
}
- (NSAttributedString *)getAttributeWith:(id)sender
                                  string:(NSString *)string
                               orginFont:(CGFloat)orginFont
                              orginColor:(UIColor *)orginColor
                           attributeFont:(CGFloat)attributeFont
                          attributeColor:(UIColor *)attributeColor
{
    __block  NSMutableAttributedString *totalStr = [[NSMutableAttributedString alloc] initWithString:string];
    [totalStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:orginFont] range:NSMakeRange(0, string.length)];
    [totalStr addAttribute:NSForegroundColorAttributeName value:orginColor range:NSMakeRange(0, string.length)];
    
    if ([sender isKindOfClass:[NSArray class]]) {
        
        __block NSString *oringinStr = string;
        __weak typeof(self) weakSelf = self;
        
        [sender enumerateObjectsUsingBlock:^(NSString *  _Nonnull str, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSRange range = [oringinStr rangeOfString:str];
            
            
            if ([str isEqualToString:@"... 展开"]) {
                [totalStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:range];
                [totalStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:range];
            }else{
                [totalStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:attributeFont] range:range];
                [totalStr addAttribute:NSForegroundColorAttributeName value:attributeColor range:range];
            }
            oringinStr = [oringinStr stringByReplacingCharactersInRange:range withString:[weakSelf getStringWithRange:range]];
        }];
        
    }else if ([sender isKindOfClass:[NSString class]]) {
        
        NSRange range = [string rangeOfString:sender];
        
        [totalStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:attributeFont] range:range];
        [totalStr addAttribute:NSForegroundColorAttributeName value:attributeColor range:range];
    }
    return totalStr;
}

- (NSString *)getStringWithRange:(NSRange)range
{
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < range.length ; i++) {
        [string appendString:@" "];
    }
    return string;
}
@end
