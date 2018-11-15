//
//  ServiceDetailView.h
//  Shh
//
//  Created by dnaer7 on 2018/11/14.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "DetailServiceRes.h"

NS_ASSUME_NONNULL_BEGIN

@interface ServiceDetailView : BaseView<UIWebViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UILabel *recommendLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *headImage;
@property(nonatomic,strong)DetailServiceRes *resultModel;
+(CGFloat)getCellHeight:(DetailServiceRes *)model;
@end

NS_ASSUME_NONNULL_END
