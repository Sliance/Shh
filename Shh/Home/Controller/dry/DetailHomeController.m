//
//  DetailHomeController.m
//  Shh
//
//  Created by zhangshu on 2018/12/18.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "DetailHomeController.h"

@interface DetailHomeController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;

@end

@implementation DetailHomeController
-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _webView.delegate = self;
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"思和会";
    }
    return self;
}
-(void)setCoumuid:(NSString *)coumuid{
    _coumuid = coumuid;
    NSString*url = [NSString stringWithFormat:@"https://v2.m.csihe.com/#/csiheService%@",coumuid];
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:request];
}

@end
