//
//  ServiceDetailView.h
//  Shh
//
//  Created by dnaer7 on 2018/11/14.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "DetailServiceRes.h"
#import "SignUpService.h"
NS_ASSUME_NONNULL_BEGIN

@interface ServiceDetailView : BaseView<UIWebViewDelegate,UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UILabel *recommendLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *serviceTitle;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *markLabel;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UITextView *markTextView;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) UIButton *fouceBtn;

@property(nonatomic,strong)DetailServiceRes *resultModel;
@property(nonatomic,strong)SignUpService *req;
+(CGFloat)getCellHeight:(DetailServiceRes *)model;
@property(nonatomic,copy)void (^subBlock)(NSString*);
@property(nonatomic,copy)void(^fouceBlock)(BOOL);

@end

NS_ASSUME_NONNULL_END
