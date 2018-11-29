//
//  HelpCell.h
//  Shh
//
//  Created by zhangshu on 2018/11/29.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "HelpRes.h"
NS_ASSUME_NONNULL_BEGIN

@interface HelpCell : BaseTableViewCell<UIWebViewDelegate>
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)HelpRes *model;
@property(nonatomic,strong)void (^heightBlock)(HelpRes *);


@end

NS_ASSUME_NONNULL_END
