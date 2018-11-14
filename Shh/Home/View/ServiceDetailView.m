//
//  ServiceDetailView.m
//  Shh
//
//  Created by dnaer7 on 2018/11/14.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "ServiceDetailView.h"

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
-(UIWebView *)webView{
    if(!_webView){
        _webView = [[UIWebView alloc]init];
        _webView.delegate = self;
        _webView.scrollView.scrollEnabled = NO;
    }
    return _webView;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    self.webView.frame = CGRectMake(0, self.titleLabel.ctBottom+20, SCREENWIDTH, self.webView.scrollView.contentSize.height);
    self.recommendLabel.frame = CGRectMake(15, self.webView.ctBottom, SCREENWIDTH-30, 18);
    self.heightBlock(self.recommendLabel.ctBottom);
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.webView];
        [self addSubview:self.recommendLabel];
        self.titleLabel.frame = CGRectMake(15, 5, SCREENWIDTH-30, 60);
    }
    return self;
}

@end
