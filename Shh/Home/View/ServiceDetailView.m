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
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.recommendLabel];
        [self addSubview:self.headImage];
        self.titleLabel.frame = CGRectMake(15, 5, SCREENWIDTH-30, 60);
        
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
    self.recommendLabel.frame = CGRectMake(15, self.headImage.ctBottom+15, SCREENWIDTH-30, 18);
}


+(CGFloat)getCellHeight:(DetailServiceRes *)model{
    UILabel *label = [[UILabel alloc]init] ;

    CGFloat height = [label getHeightLineWithString:model.siheserviceDesc withWidth:SCREENWIDTH-30 withFont:[UIFont systemFontOfSize:16]lineSpacing:5];
    height+=75;
    height+=53;
    height+=(SCREENWIDTH-20)*200/345;
    return height;
    
}
@end
