//
//  HelpCell.m
//  Shh
//
//  Created by zhangshu on 2018/11/29.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "HelpCell.h"

@implementation HelpCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 50, SCREENWIDTH, 100)];
        _webView.delegate = self;
    }
    return _webView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, SCREENWIDTH-30, 16)];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    return _titleLabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.webView];
        
    }
    return self;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    self.webView.frame = CGRectMake(0, self.titleLabel.ctBottom+15, SCREENWIDTH, self.webView.scrollView.contentSize.height);
    _model.height = self.webView.ctBottom;
    self.heightBlock(_model);
}
-(void)setModel:(HelpRes *)model{
    _model = model;
    NSString *html_str = [NSString stringWithFormat:@"<head><style>img{width:%fpx !important;}</style></head>%@",SCREENWIDTH-15,model.content];
    [self.webView loadHTMLString:html_str baseURL:nil];
    self.titleLabel.text = model.title;
    
}
@end
