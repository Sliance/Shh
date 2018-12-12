//
//  AddMemberPayController.m
//  Shh
//
//  Created by zhangshu on 2018/12/11.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "AddMemberPayController.h"
#import "HomeServiceApi.h"
#import "MemberShipController.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>

@interface AddMemberPayController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *bgScrollow;
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UIImageView *wxImage;
@property(nonatomic,strong)UILabel *wxLabel;
@property(nonatomic,strong)UIButton *wxBtn;
@property(nonatomic,strong)UIImageView *alipayImage;
@property(nonatomic,strong)UILabel *alipayLabel;
@property(nonatomic,strong)UIButton *alipayBtn;
@property(nonatomic,strong)UIButton *submitBtn;
@property(nonatomic,strong)UILabel *huiBtn;
@property(nonatomic,strong)UILabel *huiLabel;
@property(nonatomic,strong)UILabel *huiLine;
@property(nonatomic,strong)NSMutableDictionary *resultDic;
@property(nonatomic,strong)UIImageView *zongImage;
@property(nonatomic,strong)UIImageView *bottomImage;

@end

@implementation AddMemberPayController
-(UIScrollView *)bgScrollow{
    if (!_bgScrollow) {
        _bgScrollow = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _bgScrollow.delegate = self;
        _bgScrollow.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT*1.5);
    }
    return _bgScrollow;
}
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageNamed:@"logo"];
    }
    return _headImage;
}
-(UIImageView *)zongImage{
    if (!_zongImage) {
        _zongImage = [[UIImageView alloc]init];
        _zongImage.image = [UIImage imageNamed:@"pay_boss_tip"];
    }
    return _zongImage;
}
-(UIImageView *)bottomImage{
    if (!_bottomImage) {
        _bottomImage = [[UIImageView alloc]init];
       
    }
    return _bottomImage;
}
-(UIImageView *)wxImage{
    if (!_wxImage) {
        _wxImage = [[UIImageView alloc]init];
        _wxImage.image = [UIImage imageNamed:@"pay"];
    }
    return _wxImage;
}
-(UIImageView *)alipayImage{
    if (!_alipayImage) {
        _alipayImage = [[UIImageView alloc]init];
        _alipayImage.image = [UIImage imageNamed:@"alipay"];
    }
    return _alipayImage;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"思和会入学费";
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
-(UILabel *)alipayLabel{
    if (!_alipayLabel) {
        _alipayLabel = [[UILabel alloc]init];
        _alipayLabel.text = @"支付宝支付";
        _alipayLabel.font = [UIFont systemFontOfSize:14];
        _alipayLabel.textAlignment = NSTextAlignmentLeft;
        _alipayLabel.textColor = [UIColor blackColor];
    }
    return _alipayLabel;
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
-(UIButton *)alipayBtn{
    if (!_alipayBtn) {
        _alipayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_alipayBtn setImage:[UIImage imageNamed:@"wx_normal"] forState:UIControlStateNormal];
        [_alipayBtn setImage:[UIImage imageNamed:@"wx_selected"] forState:UIControlStateSelected];
        _alipayBtn.selected = NO;
        [_alipayBtn addTarget:self action:@selector(pressAlipay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _alipayBtn;
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
-(UILabel *)huiBtn{
    if (!_huiBtn) {
        _huiBtn = [[UILabel alloc]init];
        _huiBtn.text = @"会员权益";
        _huiBtn.font = [UIFont systemFontOfSize:14];
        _huiBtn.textAlignment = NSTextAlignmentLeft;
        _huiBtn.textColor = DSColorFromHex(0x969696);
        _huiBtn.numberOfLines =0;
    }
    return _huiBtn;
}
-(UILabel *)huiLine{
    if (!_huiLine) {
        _huiLine = [[UILabel alloc]init];
        _huiLine.backgroundColor = DEFAULTColor;
        _huiLine.text = @"";
    }
    return _huiLine;
}
-(UILabel *)huiLabel{
    if (!_huiLabel) {
        _huiLabel = [[UILabel alloc]init];
        _huiLabel.text = @"1.每日早晨9点准时推送行业最新资讯的思和早报\n2.每月一次的大咖分享会，与家居行业大佬进行深入交流\n3.每日干货，每日提供最新家居行业干货\n4.定期举行线下沙龙，及时了解行业动向，一起切磋，相互分享\n5.企业游学，提供家居知名企业学习机会\n6.免费加入家居私董会，把您的问题拿出来，我们一起解决\n7.免费收听每周三思和会讲师线上直播授课的家居微课堂\n8.一年6次的总裁商学院，落地实战的经营解决方案";
        _huiLabel.font = [UIFont systemFontOfSize:14];
        _huiLabel.textAlignment = NSTextAlignmentLeft;
        _huiLabel.textColor = DSColorFromHex(0x464646);
        _huiLabel.numberOfLines =0;
        
    }
    return _huiLabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.resultDic = [[NSMutableDictionary alloc]init];
    [self.view addSubview:self.bgScrollow];
    [self.bgScrollow addSubview:self.headImage];
    [self.bgScrollow addSubview:self.titleLabel];
    [self.bgScrollow addSubview:self.priceLabel];
    [self.bgScrollow addSubview:self.wxImage];
    [self.bgScrollow addSubview:self.wxLabel];
    [self.bgScrollow addSubview:self.wxBtn];
    [self.bgScrollow addSubview:self.alipayImage];
    [self.bgScrollow addSubview:self.alipayLabel];
    [self.bgScrollow addSubview:self.alipayBtn];
    [self.bgScrollow addSubview:self.submitBtn];
    [self.bgScrollow addSubview:self.huiBtn];
    [self.bgScrollow addSubview:self.huiLabel];
    [self.bgScrollow addSubview:self.huiLine];
    [self.bgScrollow addSubview:self.zongImage];
    [self.bgScrollow addSubview:self.bottomImage];
    self.headImage.frame = CGRectMake(SCREENWIDTH/2-40, 20, 81, 114);
    self.titleLabel.frame = CGRectMake(0, 20+self.headImage.ctBottom, SCREENWIDTH,20);
    self.priceLabel.frame = CGRectMake(0, 20+self.titleLabel.ctBottom, SCREENWIDTH,20);
    
    [ZSNotification addWeixinPayResultNotification:self action:@selector(weixinPay:)];
}
#pragma mark-支付回调通知

-(void)weixinPay:(NSNotification *)notifi{
    NSDictionary *userInfo = [notifi userInfo];
    if ([[userInfo objectForKey:@"weixinpay"] isEqualToString:@"success"]) {
        [self showInfo:@"付款成功"];
    }
    [self showInfo:[userInfo objectForKey:@"strMsg"]];
}
-(void)setContentLauout{
    self.wxImage.frame = CGRectMake(15, self.zongImage.ctBottom+50, 24, 24);
    self.wxLabel.frame = CGRectMake(self.wxImage.ctRight+10,self.zongImage.ctBottom+50 , 100, 24);
    self.wxBtn.frame = CGRectMake(SCREENWIDTH-55, self.zongImage.ctBottom+42, 40, 40);
    self.alipayImage.frame = CGRectMake(15, self.wxBtn.ctBottom+10, 24, 24);
    self.alipayLabel.frame = CGRectMake(self.wxImage.ctRight+10,self.wxBtn.ctBottom+10 , 100, 24);
    self.alipayBtn.frame = CGRectMake(SCREENWIDTH-55, self.wxBtn.ctBottom+2, 40, 40);
    self.submitBtn.frame = CGRectMake(15, self.alipayImage.ctBottom+40, SCREENWIDTH-30, 40);
    self.huiLine.frame = CGRectMake(15, self.submitBtn.bottom+30, 5, 20);
    self.huiBtn.frame = CGRectMake(self.huiLine.ctRight+5, self.submitBtn.bottom+30, 100, 20);
    self.bottomImage.frame = CGRectMake(15, self.huiBtn.ctBottom+10, SCREENWIDTH-30, 382*(SCREENWIDTH-30)/345);
    self.bgScrollow.contentSize = CGSizeMake(SCREENWIDTH, self.bottomImage.ctBottom+50);
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
   
}
-(void)setType:(NSInteger )type{
    _type = type;
    if (type ==0) {
        _titleLabel.text = @"思和会入学费";
       
        [_huiLabel setText:@"1.每日早晨9点准时推送行业最新资讯的思和早报\n2.每月一次的大咖分享会，与家居行业大佬进行深入交流\n3.每日干货，每日提供最新家居行业干货\n4.定期举行线下沙龙，及时了解行业动向，一起切磋，相互分享\n5.企业游学，提供家居知名企业学习机会\n6.免费加入家居私董会，把您的问题拿出来，我们一起解决\n7.免费收听每周三思和会讲师线上直播授课的家居微课堂\n8.一年6次的总裁商学院，落地实战的经营解决方案" lineSpacing:5];
    }else if (type ==1){
        _titleLabel.text = @"加入研习社";
        _bottomImage.image = [UIImage imageNamed:@"yanxi_bg"];
        self.zongImage.frame = CGRectMake(SCREENWIDTH/2-160, self.priceLabel.ctBottom+30, 320, 0);
        [self setContentLauout];
        [self addMember:@"studyClub"];
    }else if (type ==2){
        _titleLabel.text = @"加入总裁班";
         _bottomImage.image = [UIImage imageNamed:@"zong_bg"];
       self.zongImage.frame = CGRectMake(SCREENWIDTH/2-160, self.priceLabel.ctBottom+30, 320, 50);
        [self setContentLauout];
        [self addMember:@"presidentClasses"];
    }
}
-(void)setOrderId:(NSString *)orderId{
    _orderId = orderId;
    [self addMember:@""];
}


-(void)addMember:(NSString*)types{
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.pageIndex = 1;
    req.pageSize = @"100";
    req.courseId = self.courseId;
    req.type = types;
    __weak typeof(self)weakself = self;
    [[HomeServiceApi share]addMemberPayWithParam:req response:^(id response) {
        if ([response[@"code"] integerValue] ==200) {
            weakself.resultDic = response[@"data"];
            weakself.priceLabel.text = [NSString stringWithFormat:@"￥%@",weakself.resultDic[@"levelPrice"]];
        }
    }];
}

-(void)pressWx:(UIButton*)sender{
    
    self.wxBtn.selected = YES;
    self.alipayBtn.selected = NO;
}
-(void)pressAlipay{
    self.wxBtn.selected = NO;
    self.alipayBtn.selected = YES;
}
-(void)pressSubmit{
    if (self.wxBtn.selected ==NO&&self.alipayBtn.selected == NO) {
        [self showInfo:@"请选择付款方式"];
        return;
    }
    FreeListReq *req = [[FreeListReq alloc]init];
    req.appId = @"1041622992853962754";
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.platform = @"ios";
    req.orderId = self.orderId;
    if (self.wxBtn.selected == YES) {
        [[HomeServiceApi share]getWxPayWithParam:req response:^(id response) {
            if(response){
                OrderPayRes *model = response;
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.partnerId           = model.partnerid;
                req.prepayId            = model.prepayid;
                req.nonceStr            = model.noncestr;
                req.timeStamp           = model.timestamp.intValue;
                req.package             = model.packagestr;
                req.sign                = model.sign;
                [WXApi sendReq:req];
            }
        }];
    }else if (self.alipayBtn.selected ==YES){
        [[HomeServiceApi share]getAlipayWithParam:req response:^(id response) {
            if (response) {
                OrderPayRes *model = response;
                NSString *appScheme = @"ShhScheme";
                [[AlipaySDK defaultService] payOrder:model.body fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                    NSLog(@"reslut = %@",resultDic);
                }];
            }
        }];
    }
    
    
}
-(void)pressHui{
    MemberShipController*memberVC = [[MemberShipController alloc]init];
    [self.navigationController pushViewController:memberVC animated:YES];
}

@end
