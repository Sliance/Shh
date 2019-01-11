//
//  ServiceDetailView.m
//  Shh
//
//  Created by dnaer7 on 2018/11/14.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "ServiceDetailView.h"
#import "ServiceApi.h"

@implementation ServiceDetailView


-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = DSColorFromHex(0x474747);
        _titleLabel.font = [UIFont boldSystemFontOfSize:21];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}
-(UILabel *)recommendLabel{
    if (!_recommendLabel) {
        _recommendLabel = [[UILabel alloc]init];
        _recommendLabel.textColor = DSColorFromHex(0x474747);
        _recommendLabel.font = [UIFont boldSystemFontOfSize:18];
        _recommendLabel.textAlignment = NSTextAlignmentLeft;
        _recommendLabel.text = @"相关推荐";
    }
    return _recommendLabel;
}
-(UILabel *)serviceTitle{
    if (!_serviceTitle) {
        _serviceTitle = [[UILabel alloc]init];
        _serviceTitle.textColor = DSColorFromHex(0x474747);
        _serviceTitle.font = [UIFont boldSystemFontOfSize:18];
        _serviceTitle.textAlignment = NSTextAlignmentLeft;
        _serviceTitle.text = @"服务报名";
    }
    return _serviceTitle;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = DSColorFromHex(0x474747);
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.numberOfLines =0;
    }
    return _contentLabel;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = DSColorFromHex(0x474747);
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.text =@"*您的姓名";
    }
    return _nameLabel;
}
-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.textColor = DSColorFromHex(0x474747);
        _phoneLabel.font = [UIFont systemFontOfSize:12];
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        _phoneLabel.text =@"*您的手机";
    }
    return _phoneLabel;
}
-(UILabel *)markLabel{
    if (!_markLabel) {
        _markLabel = [[UILabel alloc]init];
        _markLabel.textColor = DSColorFromHex(0x474747);
        _markLabel.font = [UIFont systemFontOfSize:12];
        _markLabel.textAlignment = NSTextAlignmentLeft;
        _markLabel.text =@" 备注";
    }
    return _markLabel;
}
-(UITextField *)nameField{
    if (!_nameField) {
        _nameField = [[UITextField alloc]init];
        _nameField.backgroundColor = DSColorFromHex(0xF0F0F0);
        [_nameField.layer setCornerRadius:3];
        [_nameField.layer setBorderColor:DSColorFromHex(0xDCDCDC).CGColor];
        [_nameField.layer setBorderWidth:0.5];
        _nameField.textColor = DSColorFromHex(0x474747);
        _nameField.font = [UIFont systemFontOfSize:12];
        _nameField.delegate = self;
        _nameField.tag =1;
    }
    return _nameField;
}
-(UITextField *)phoneField{
    if (!_phoneField) {
        _phoneField = [[UITextField alloc]init];
        _phoneField.backgroundColor = DSColorFromHex(0xF0F0F0);
        [_phoneField.layer setCornerRadius:3];
        [_phoneField.layer setBorderColor:DSColorFromHex(0xDCDCDC).CGColor];
        [_phoneField.layer setBorderWidth:0.5];
        _phoneField.textColor = DSColorFromHex(0x474747);
        _phoneField.font = [UIFont systemFontOfSize:12];
        _phoneField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneField.delegate = self;
        _phoneField.tag = 2;
    }
    return _phoneField;
}
-(UITextView *)markTextView{
    if (!_markTextView) {
        _markTextView = [[UITextView alloc]init];
        _markTextView.backgroundColor = DSColorFromHex(0xF0F0F0);
        [_markTextView.layer setCornerRadius:3];
        [_markTextView.layer setBorderColor:DSColorFromHex(0xDCDCDC).CGColor];
        [_markTextView.layer setBorderWidth:0.5];
        _markTextView.textColor = DSColorFromHex(0x474747);
        _markTextView.font = [UIFont systemFontOfSize:12];
        _markTextView.delegate = self;
        _markTextView.tag = 3;
    }
    return _markTextView;
}
-(UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn   = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.backgroundColor = DEFAULTColor;
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_submitBtn.layer setCornerRadius:3];
        [_submitBtn addTarget:self action:@selector(pressSubmit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}
-(UIWebView *)webView{
    if(!_webView){
        _webView = [[UIWebView alloc]init];
        _webView.delegate = self;
        _webView.scrollView.scrollEnabled = NO;
    }
    return _webView;
}
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
    }
    return _headImage;
}
-(UIButton *)fouceBtn{
    if (!_fouceBtn) {
        _fouceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _fouceBtn.backgroundColor = DSColorFromHex(0xE70019);
        [_fouceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_fouceBtn setTitle:@"关注" forState:UIControlStateNormal];
        [_fouceBtn setTitleColor:DSColorFromHex(0x969696) forState:UIControlStateSelected];
        [_fouceBtn setTitle:@"已关注" forState:UIControlStateSelected];
        _fouceBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [_fouceBtn.layer setCornerRadius:3];
        [_fouceBtn addTarget:self action:@selector(pressFouce:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fouceBtn;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.recommendLabel];
        [self addSubview:self.headImage];
        [self addSubview:self.serviceTitle];
        [self addSubview:self.nameLabel];
        [self addSubview:self.phoneLabel];
        [self addSubview:self.markLabel];
        [self addSubview:self.nameField];
        [self addSubview:self.phoneField];
        [self addSubview:self.markTextView];
        [self addSubview:self.submitBtn];
        [self addSubview:self.fouceBtn];
        [self addSubview:self.webView];
        self.titleLabel.frame = CGRectMake(15, 5, SCREENWIDTH-70, 60);
        self.fouceBtn.frame = CGRectMake(SCREENWIDTH-55, 15, 40, 20);
        self.req = [[SignUpService alloc]init];
    }
    return self;
}
-(void)setResultModel:(DetailServiceRes *)resultModel{
    _resultModel = resultModel;
    self.titleLabel.text = resultModel.siheserviceTitle;
    self.contentLabel.text = resultModel.siheserviceDesc;
    NSString *url = [NSString stringWithFormat:@"%@%@",DPHOST,resultModel.siheserviceAppImagePath];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
    [self.contentLabel setText:resultModel.siheserviceDesc lineSpacing:5];
    self.contentLabel.frame = CGRectMake(15, self.titleLabel.ctBottom, SCREENWIDTH-30, [self.contentLabel getHeightLineWithString:resultModel.siheserviceDesc withWidth:SCREENWIDTH-30 withFont:[UIFont systemFontOfSize:16] lineSpacing:5]);
     self.headImage.frame = CGRectMake(10, self.contentLabel.ctBottom+15, SCREENWIDTH-20, (SCREENWIDTH-20)*200/345);
    self.webView.frame = CGRectMake(0, self.headImage.ctBottom, SCREENWIDTH, 100);
    NSString *html_str = [resultModel.siheserviceContent stringByReplacingOccurrencesOfString:@"height:100%" withString:@"height:auto"];
    [self.webView loadHTMLString:resultModel.siheserviceContent baseURL:nil];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    self.webView.frame = CGRectMake(0, self.headImage.ctBottom+20, SCREENWIDTH, self.webView.scrollView.contentSize.height);
    self.serviceTitle.frame = CGRectMake(15, self.webView.ctBottom+15, SCREENWIDTH-30, 18);
    self.nameLabel.frame = CGRectMake(30, self.serviceTitle.ctBottom+20, 60, 40);
    self.phoneLabel.frame = CGRectMake(30, self.nameLabel.ctBottom, 60, 40);
    self.markLabel.frame = CGRectMake(30, self.phoneLabel.ctBottom, 60, 40);
    self.nameField.frame = CGRectMake(self.nameLabel.ctRight+10, self.nameLabel.ctTop+5, SCREENWIDTH-120, 30);
    self.phoneField.frame = CGRectMake(self.phoneLabel.ctRight+10, self.phoneLabel.ctTop+5, SCREENWIDTH-120, 30);
    self.markTextView.frame = CGRectMake(self.markLabel.ctRight+10, self.markLabel.ctTop+5, SCREENWIDTH-120, 50);
    self.submitBtn.frame = CGRectMake(30, self.markTextView.ctBottom+15, SCREENWIDTH-60, 30);
    self.recommendLabel.frame = CGRectMake(15, self.submitBtn.ctBottom+20, SCREENWIDTH-30, 18);
    self.heightBlock(self.recommendLabel.ctBottom+15);
    NSLog(@"$$$$$$$%f",self.recommendLabel.ctBottom);
}

+(CGFloat)getCellHeight:(DetailServiceRes *)model{
    UILabel *label = [[UILabel alloc]init] ;

    CGFloat height = [label getHeightLineWithString:model.siheserviceDesc withWidth:SCREENWIDTH-30 withFont:[UIFont systemFontOfSize:16]lineSpacing:5];
    height+= 175+150;
    height+=53;
    height+=(SCREENWIDTH-20)*200/345;
    
    return height;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag ==1) {
        
    }
    return YES;
}
-(void)pressSubmit{
    [self endEditing:YES];
    self.req.appId = @"1041622992853962754";
    self.req.timestamp = @"0";
    self.req.platform = @"ios";
    self.req.token = [UserCacheBean share].userInfo.token;
    self.req.siheserviceFormName = self.nameField.text;
    self.req.siheserviceFormPhone = self.phoneField.text;
    self.req.siheserviceId = self.resultModel.siheserviceId;
    self.req.siheserviceFormContent = self.markTextView.text;
    [[ServiceApi share]signUpServiceListWithParam:self.req response:^(id response) {
        if (response) {
            self.subBlock(response[@"message"]);
        }
    }];
}
-(void)pressFouce:(UIButton*)sender{
    self.fouceBlock(sender.selected);
}

@end
