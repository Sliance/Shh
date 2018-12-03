//
//  PayViewController.m
//  Shh
//
//  Created by zhangshu on 2018/12/3.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "PayViewController.h"
#import "HomeServiceApi.h"
#import "MemberShipController.h"

@interface PayViewController ()
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UIImageView *wxImage;
@property(nonatomic,strong)UILabel *wxLabel;
@property(nonatomic,strong)UIButton *wxBtn;
@property(nonatomic,strong)UIButton *submitBtn;
@property(nonatomic,strong)UIButton *huiBtn;
@property(nonatomic,strong)UILabel *huiLabel;
@property(nonatomic,strong)NSMutableDictionary *resultDic;



@end

@implementation PayViewController
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageNamed:@"logo"];
    }
    return _headImage;
}
-(UIImageView *)wxImage{
    if (!_wxImage) {
        _wxImage = [[UIImageView alloc]init];
        _wxImage.image = [UIImage imageNamed:@"pay"];
    }
    return _wxImage;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"成功经销商的目标管理";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.text = @"￥0";
        _priceLabel.font = [UIFont boldSystemFontOfSize:18];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.textColor = DEFAULTColor;
    }
    return _priceLabel;
}
-(UILabel *)wxLabel{
    if (!_wxLabel) {
        _wxLabel = [[UILabel alloc]init];
        _wxLabel.text = @"微信支付";
        _wxLabel.font = [UIFont systemFontOfSize:14];
        _wxLabel.textAlignment = NSTextAlignmentLeft;
        _wxLabel.textColor = [UIColor blackColor];
    }
    return _wxLabel;
}
-(UIButton *)wxBtn{
    if (!_wxBtn) {
        _wxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wxBtn setImage:[UIImage imageNamed:@"wx_normal"] forState:UIControlStateNormal];
        [_wxBtn setImage:[UIImage imageNamed:@"wx_selected"] forState:UIControlStateSelected];
        _wxBtn.selected = YES;
        [_wxBtn addTarget:self action:@selector(pressWx:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wxBtn;
}
-(UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"确认支付" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _submitBtn.backgroundColor = DEFAULTColor;
        [_submitBtn.layer setCornerRadius:4];
        [_submitBtn.layer setMasksToBounds:YES];
        [_submitBtn addTarget:self action:@selector(pressSubmit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}
-(UIButton *)huiBtn{
    if (!_huiBtn) {
        _huiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_huiBtn setTitle:@"点击入会" forState:UIControlStateNormal];
        [_huiBtn setTitleColor:DEFAULTColor forState:UIControlStateNormal];
        _huiBtn.titleLabel.font = [UIFont systemFontOfSize:14];
       
        [_huiBtn addTarget:self action:@selector(pressHui) forControlEvents:UIControlEventTouchUpInside];
    }
    return _huiBtn;
}
-(UILabel *)huiLabel{
    if (!_huiLabel) {
        _huiLabel = [[UILabel alloc]init];
        _huiLabel.text = @"在线会员免费观看";
        _huiLabel.font = [UIFont systemFontOfSize:14];
        _huiLabel.textAlignment = NSTextAlignmentCenter;
        _huiLabel.textColor = DSColorFromHex(0x969696);
    }
    return _huiLabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.resultDic = [[NSMutableDictionary alloc]init];
    [self.view addSubview:self.headImage];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.priceLabel];
    [self.view addSubview:self.wxImage];
    [self.view addSubview:self.wxLabel];
    [self.view addSubview:self.wxBtn];
    [self.view addSubview:self.submitBtn];
    [self.view addSubview:self.huiBtn];
    [self.view addSubview:self.huiLabel];
    [self setContentLauout];
}
-(void)setContentLauout{
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(30+[self navHeightWithHeight]);
        make.centerX.equalTo(self.view);
        
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImage.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
    }];
    [self.wxImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(30);
        
    }];
    [self.wxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.wxImage.mas_right).offset(10);
        make.centerY.equalTo(self.wxImage);
    }];
    [self.wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.centerY.equalTo(self.wxImage);
    }];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.equalTo(self.view).offset(-15);
         make.left.equalTo(self.view).offset(15);
        make.top.equalTo(self.wxImage.mas_bottom).offset(40);
        make.height.mas_equalTo(40);
    }];
    [self.huiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-100);
        make.left.equalTo(self.view).offset(100);
        make.top.equalTo(self.submitBtn.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
    [self.huiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.top.equalTo(self.huiBtn.mas_bottom).offset(0);
        
    }];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"支付";
    }
    return self;
}
-(void)setCourseId:(NSString *)courseId{
    _courseId = courseId;
    [self buyCourseData];
}
-(void)buyCourseData{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.pageIndex = 1;
    req.pageSize = @"100";
    req.courseId = self.courseId;
    __weak typeof(self)weakself = self;
    [[HomeServiceApi share]buyCourseWithParam:req response:^(id response) {
        if ([response[@"code"] integerValue] ==200) {
            weakself.resultDic = response[@"data"];
            weakself.priceLabel.text = [NSString stringWithFormat:@"￥%@",weakself.resultDic[@"orderRealAmount"]];
        }
    }];
}

-(void)pressWx:(UIButton*)sender{
    sender.selected = !sender.selected;
}
-(void)pressSubmit{
    if (self.wxBtn.selected ==NO) {
        [self showInfo:@"请选择付款方式"];
        return;
    }
    
}
-(void)pressHui{
    MemberShipController*memberVC = [[MemberShipController alloc]init];
    [self.navigationController pushViewController:memberVC animated:YES];
}
@end
