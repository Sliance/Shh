//
//  MineFootView.m
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "MineFootView.h"
#import "MineTypeBtn.h"

@implementation MineFootView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setLayout];
    }
    return self;
}
-(void)setLayout{
    [self addSubview:self.bgView];
    
    NSArray *leftArr = @[@"xueye_mine",@"invite_mine",@"service_mine",@"phone_mine"];
    NSArray *titleArr = @[@"开通学籍",@"邀请好友加入",@"在线咨询",@"电话咨询     "];
    for (int i = 0; i<leftArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15+i%2*((SCREENWIDTH-75)/2+15), 10+i/2*50, (SCREENWIDTH-75)/2, 40);
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.backgroundColor = DSColorFromHex(0xFAFAFA);
        [btn setTitleColor:DSColorFromHex(0x797979) forState:UIControlStateNormal];
        [btn.layer setCornerRadius:20];
        [btn.layer setMasksToBounds:YES];
        [btn setImage:[UIImage imageNamed:leftArr[i]] forState:UIControlStateNormal];
        [btn setIconInLeftWithSpacing:11];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(pressHead:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:btn];
    }
    NSArray *imageArr= @[@"\U0000e908",@"\U0000e90c",@"\U0000e92a",@"\U0000e924",@"\U0000e922",@"\U0000e919",@"\U0000e917",@"\U0000e900"];
    //@"\U0000e907"
    NSArray *dataArr = @[@"我的购买",@"我的积分",@"我的勋章",@"我的收藏",@"我的关注",@"设置",@"入驻思和会",@"帮助中心"];

    for (int i = 0; i<imageArr.count; i++) {
        MineTypeBtn *btn = [[MineTypeBtn alloc]initWithFrame:CGRectMake(i%3*(SCREENWIDTH/3-10), 120+i/3*88, SCREENWIDTH/3-10, 88)];
        btn.imageLabel.font = [UIFont fontWithName:@"icomoon"size:26];
        btn.imageLabel.text = imageArr[i];
        btn.typeLabel.text = dataArr[i];
        btn.tag = i;
        btn.backgroundColor = [UIColor whiteColor];
        btn.imageLabel.textColor = DSColorFromHex(0x464646);
        btn.typeLabel.textColor = DSColorFromHex(0x777777);
        
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:btn];
    }
    
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
        [_bgView.layer setCornerRadius:8];
        [_bgView.layer setMasksToBounds:YES];
        _bgView.frame = CGRectMake(15, 10, SCREENWIDTH-30, 395);
    }
    return _bgView;
}







-(void)pressBtn:(MineTypeBtn*)sender{
    self.selecteBlock(sender.tag);
}
-(void)pressHead:(UIButton*)sender{
    self.headBlock(sender.tag);
}

@end
