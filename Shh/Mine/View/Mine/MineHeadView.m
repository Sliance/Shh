//
//  MineHeadView.m
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "MineHeadView.h"
#import "MineTypeBtn.h"
#import "MineServiceApi.h"


@implementation MineHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = DSColorFromHex(0xFAFAFA);
        [self setLayout];
    }
    return self;
}

-(void)setLayout{
    [self addSubview:self.bgImage];
    [self addSubview:self.bgView];
    [self addSubview:self.headImage];
    [self.bgView addSubview:self.hYView];
    [self.hYView addSubview:self.openBtn];
    [self.hYView addSubview:self.memberBtn];
    [self.hYView addSubview:self.studyBtn];
    [self.hYView addSubview:self.presidentBtn];
    [self.bgView addSubview:self.nameLabel];
    [self.bgView addSubview:self.editBtn];
    [self.bgImage addSubview:self.messageBtn];
    [self.bgImage addSubview:self.serviceBtn];
    self.btnArr = [[NSMutableArray alloc]init];
    NSArray *imageArr= @[@"\U0000e916",@"\U0000e913",@"\U0000e927"];
    NSArray *dataArr = @[@"签到",@"历史",@"下载"];
    for (int i = 0; i<3; i++) {
        MineTypeBtn *btn = [[MineTypeBtn alloc]initWithFrame:CGRectMake(i*(SCREENWIDTH/3-10), 70, SCREENWIDTH/3-10, 80)];
        btn.imageLabel.font = [UIFont fontWithName:@"icomoon"size:26];
        btn.imageLabel.text = imageArr[i];
        btn.typeLabel.text = dataArr[i];
        btn.tag = i;
        btn.backgroundColor = [UIColor whiteColor];
        btn.imageLabel.textColor = DSColorFromHex(0x464646);
        btn.typeLabel.textColor = DSColorFromHex(0x464646);
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:btn];
        [self.btnArr addObject:btn];
    }

    self.editBtn.frame = CGRectMake(SCREENWIDTH/2-65, 46, 100, 15);
   
}
-(UIImageView *)bgImage{
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc]init];
        _bgImage.image = [UIImage imageNamed:@"bg_mine"];
        _bgImage.frame = CGRectMake(0, 0, SCREENWIDTH, 250);
        _bgImage.userInteractionEnabled = YES;
    }
    return _bgImage;
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
        [_bgView.layer setCornerRadius:8];
        [_bgView.layer setMasksToBounds:YES];
        _bgView.frame = CGRectMake(15, 85, SCREENWIDTH-30, 200);
    }
    return _bgView;
}
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageNamed:@"mine"];
        _headImage.frame = CGRectMake(SCREENWIDTH/2-37, 48, 74, 74);
        [_headImage.layer setCornerRadius:37];
        [_headImage.layer setMasksToBounds:YES];
        [_headImage.layer setBorderColor:[UIColor whiteColor].CGColor];
        [_headImage.layer setBorderWidth:0.5];
        _headImage.userInteractionEnabled = YES;
    }
    return _headImage;
}
-(UIView *)hYView{
    if (!_hYView) {
        _hYView = [[UIView alloc]init];
        _hYView.backgroundColor = DSColorFromHex(0xCDB59C);
        _hYView.frame = CGRectMake(0, 165, SCREENWIDTH-30, 35);
        _hYView.userInteractionEnabled = YES;
    }
    return _hYView;
}
-(UILabel *)hYimage{
    if (!_hYimage) {
        _hYimage = [[UILabel alloc]init];
        _hYimage.font = [UIFont fontWithName:@"icomoon"size:16];
        _hYimage.text = @"\U0000e92e";
        _hYimage.textColor = DSColorFromHex(0x52402C);
        _hYimage.frame = CGRectMake(15, 9, 21, 16);
    }
    return _hYimage;
}
-(UILabel *)hYtitle{
    if (!_hYtitle) {
        _hYtitle = [[UILabel alloc]init];
        _hYtitle.textAlignment = NSTextAlignmentLeft;
        _hYtitle.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _hYtitle.textColor = DSColorFromHex(0x52402C);
        _hYtitle.text = @"思和会会员";
        _hYtitle.numberOfLines = 1;
        _hYtitle.frame = CGRectMake(52, 0, 80, 35);
    }
    return _hYtitle;
}
-(UILabel *)hYDate{
    if (!_hYDate) {
        _hYDate = [[UILabel alloc]init];
        _hYDate.textAlignment = NSTextAlignmentRight;
        _hYDate.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _hYDate.textColor = DSColorFromHex(0x52402C);
        _hYDate.text = @"加入会员 >";
        _hYDate.numberOfLines = 1;
        _hYDate.frame = CGRectMake(SCREENWIDTH-30-110, 0, 100, 35);
        _hYDate.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressTap)];
        [_hYDate addGestureRecognizer:tap];
    }
    return _hYDate;
}
-(UIButton *)editBtn{
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setTitle:@"未登录" forState:UIControlStateNormal];
        _editBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_editBtn setTitleColor:DSColorFromHex(0x454545) forState:UIControlStateNormal];
        [_editBtn addTarget:self action:@selector(pressEdit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}
-(UIButton *)messageBtn{
    if (!_messageBtn) {
        _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_messageBtn setTitle:@"\U0000e928" forState:UIControlStateNormal];
        _messageBtn.titleLabel.font = [UIFont fontWithName:@"icomoon"size:26];
        [_messageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _messageBtn.frame = CGRectMake(0, 20, 58, 54);
        [_messageBtn addTarget:self action:@selector(pressMessage:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _messageBtn;
}
-(UIButton *)serviceBtn{
    if (!_serviceBtn) {
        _serviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_serviceBtn setTitle:@"\U0000e90f" forState:UIControlStateNormal];
        _serviceBtn.titleLabel.font = [UIFont fontWithName:@"icomoon"size:27];
        [_serviceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _serviceBtn.frame = CGRectMake(SCREENWIDTH-23-15, 36, 23, 23);
    }
    return _serviceBtn;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:16];
        _nameLabel.textColor = DSColorFromHex(0x454545);
        _nameLabel.text = @"唐瑛";
    }
    return _nameLabel;
}
-(UIButton *)openBtn{
    if (!_openBtn) {
        _openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if ([UserCacheBean share].userInfo.isShow ==NO) {
            [_openBtn setTitle:@"学籍 >" forState:UIControlStateNormal];
        }else{
            [_openBtn setTitle:@"开通学籍  享受特权 >" forState:UIControlStateNormal];
        }
        
        [_openBtn setTitleColor:DSColorFromHex(0x52402C) forState:UIControlStateNormal];
        _openBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_openBtn addTarget:self action:@selector(pressAdd) forControlEvents:UIControlEventTouchUpInside];
    }
    return _openBtn;
}
-(UIButton *)memberBtn{
    if (!_memberBtn) {
        _memberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_memberBtn setTitleColor:DSColorFromHex(0x52402C) forState:UIControlStateNormal];
        _memberBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_memberBtn setTitle:@"思和会会员" forState:UIControlStateNormal];
        [_memberBtn setImage:[UIImage imageNamed:@"vip_mine"] forState:UIControlStateNormal];
    }
    return _memberBtn;
}
-(UIButton *)studyBtn{
    if (!_studyBtn) {
        _studyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_studyBtn setTitleColor:DSColorFromHex(0x52402C) forState:UIControlStateNormal];
        _studyBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_studyBtn setTitle:@"研习社" forState:UIControlStateNormal];
        [_studyBtn setImage:[UIImage imageNamed:@"vip_mine"] forState:UIControlStateNormal];
    }
    return _studyBtn;
}
-(UIButton *)presidentBtn{
    if (!_presidentBtn) {
        _presidentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_presidentBtn setTitleColor:DSColorFromHex(0x52402C) forState:UIControlStateNormal];
        _presidentBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_presidentBtn setTitle:@"总裁班" forState:UIControlStateNormal];
        [_presidentBtn setImage:[UIImage imageNamed:@"vip_mine"] forState:UIControlStateNormal];
    }
    return _presidentBtn;
}
-(void)pressBtn:(MineTypeBtn*)sender{
    if (sender.tag==0) {
        if ([UserCacheBean share].userInfo.token.length>0) {
            FreeListReq *req = [[FreeListReq alloc]init];
            req.appId = @"1041622992853962754";
            req.timestamp = @"0";
            req.platform = @"ios";
            req.token = [UserCacheBean share].userInfo.token;
            req.memberId = [UserCacheBean share].userInfo.memberId;
           
            [[MineServiceApi share]getSignInWithParam:req response:^(id response) {
                if ([response[@"code"] integerValue] ==200) {
                    sender.imageLabel.textColor = DSColorFromHex(0x969696);
                    sender.typeLabel.textColor = DSColorFromHex(0x969696);
                    sender.typeLabel.text =@"已签到";
                    sender.enabled = NO;
                }
            }];
        }else{
            self.typeBlock(sender.tag);
        }
        
    }else{
        self.typeBlock(sender.tag);
    }
}
-(void)setModel:(MemberInfoRes *)model{
    _model = model;
    if (model.signIn == 1) {
        [self.btnArr enumerateObjectsUsingBlock:^(MineTypeBtn *btn, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == 0) {
                if ([UserCacheBean share].userInfo.token.length>0) {
                    btn.imageLabel.textColor = DSColorFromHex(0x969696);
                    btn.typeLabel.textColor = DSColorFromHex(0x969696);
                    btn.typeLabel.text =@"已签到";
                    btn.enabled = NO;
                }else{
                    btn.imageLabel.textColor = DSColorFromHex(0x464646);
                    btn.typeLabel.textColor = DSColorFromHex(0x464646);
                    btn.typeLabel.text =@"签到";
                    btn.enabled = YES;
                }
                
            }
        }];
    }else{
        [self.btnArr enumerateObjectsUsingBlock:^(MineTypeBtn *btn, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == 0) {
                btn.imageLabel.textColor = DSColorFromHex(0x464646);
                btn.typeLabel.textColor = DSColorFromHex(0x464646);
                btn.typeLabel.text =@"签到";
                btn.enabled = YES;
            }
        }];
    }
    if ([UserCacheBean share].userInfo.isShow ==NO) {
        self.memberBtn.frame = CGRectZero;
        self.studyBtn.frame = CGRectZero;
        self.presidentBtn.frame = CGRectZero;
    }else{
    if (model.joinMember ==0&&model.studyStatus ==0&&model.presidentStatus ==0) {
        self.openBtn.frame = CGRectMake(0, 0, SCREENWIDTH-30, 35);
        self.memberBtn.frame = CGRectZero;
        self.studyBtn.frame = CGRectZero;
        self.presidentBtn.frame = CGRectZero;
    }else if (model.joinMember ==1&&model.studyStatus ==0&&model.presidentStatus ==0){
        self.memberBtn.frame = CGRectMake(0, 0, SCREENWIDTH-30, 35);
        self.openBtn.frame = CGRectZero;
        self.studyBtn.frame = CGRectZero;
        self.presidentBtn.frame = CGRectZero;
        [self.memberBtn setIconInLeftWithSpacing:10];
    }else if (model.joinMember ==0&&model.studyStatus ==1&&model.presidentStatus ==0){
        self.studyBtn.frame = CGRectMake(0, 0, SCREENWIDTH-30, 35);
        self.memberBtn.frame = CGRectZero;
        self.openBtn.frame = CGRectZero;
        self.presidentBtn.frame = CGRectZero;
        [self.studyBtn setIconInLeftWithSpacing:10];
    }else if (model.joinMember ==0&&model.studyStatus ==0&&model.presidentStatus ==1){
        self.presidentBtn.frame = CGRectMake(0, 0, SCREENWIDTH-30, 35);
        self.memberBtn.frame = CGRectZero;
        self.openBtn.frame = CGRectZero;
        self.studyBtn.frame = CGRectZero;
        [self.presidentBtn setIconInLeftWithSpacing:10];
    }else if (model.joinMember ==1&&model.studyStatus ==1&&model.presidentStatus ==0){
        self.memberBtn.frame = CGRectMake(0, 0, SCREENWIDTH/2-15, 35);
        self.studyBtn.frame = CGRectMake(SCREENWIDTH/2-15, 0, SCREENWIDTH/2-15, 35);
        self.openBtn.frame = CGRectZero;
        self.presidentBtn.frame = CGRectZero;
         [self.memberBtn setIconInLeftWithSpacing:10];
         [self.studyBtn setIconInLeftWithSpacing:10];
    }else if (model.joinMember ==1&&model.studyStatus ==0&&model.presidentStatus ==1){
        self.memberBtn.frame = CGRectMake(0, 0, SCREENWIDTH/2-15, 35);
        self.presidentBtn.frame = CGRectMake(SCREENWIDTH/2-15, 0, SCREENWIDTH/2-15, 35);
        self.openBtn.frame = CGRectZero;
        self.studyBtn.frame = CGRectZero;
         [self.memberBtn setIconInLeftWithSpacing:10];
         [self.presidentBtn setIconInLeftWithSpacing:10];
    }else if (model.joinMember ==0&&model.studyStatus ==1&&model.presidentStatus ==1){
        self.studyBtn.frame = CGRectMake(0, 0, SCREENWIDTH/2-15, 35);
        self.presidentBtn.frame = CGRectMake(SCREENWIDTH/2-15, 0, SCREENWIDTH/2-15, 35);
        self.openBtn.frame = CGRectZero;
        self.memberBtn.frame = CGRectZero;
         [self.studyBtn setIconInLeftWithSpacing:10];
         [self.presidentBtn setIconInLeftWithSpacing:10];
    }
 }
    
}
-(void)pressMessage:(UIButton*)sender{
    self.messageBlock();
}
-(void)pressEdit{
    self.editBlock();
}

-(void)pressAdd{
    self.addBlock();
}
@end
