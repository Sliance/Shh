//
//  ServiceDetailView.h
//  Shh
//
//  Created by dnaer7 on 2018/11/14.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ServiceDetailView : BaseView
<UIWebViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UILabel *recommendLabel;
@property(nonatomic,copy)void(^heightBlock)(CGFloat);
@end

NS_ASSUME_NONNULL_END
