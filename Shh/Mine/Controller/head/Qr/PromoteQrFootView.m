//
//  PromoteQrFootView.m
//  Shh
//
//  Created by zhangshu on 2018/12/4.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "PromoteQrFootView.h"

@implementation PromoteQrFootView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleBtn];
        [self addSubview:self.contentLabel];
    }
    return self;
}
-(UIButton *)titleBtn{
    if (!_titleBtn) {
        _titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_titleBtn setTitle:@"转发指南" forState:UIControlStateNormal];
        [_titleBtn setImage:[UIImage imageNamed:@"down_mine"] forState:UIControlStateNormal];
        [_titleBtn setImage:[UIImage imageNamed:@"up_mine"] forState:UIControlStateSelected];
        _titleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_titleBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
        _titleBtn.frame = CGRectMake(0, 0, SCREENWIDTH, 50);
         [_titleBtn setIconInTopWithSpacing:3];
        [_titleBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleBtn;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textColor = DSColorFromHex(0x464646);
        NSString*content = @"1、如何转发\n您可以使用本页右上角的“转发”键，将突破分享至微信朋友或朋友圈。\n2、为何要转发\n据说，上帝赐予人类三种力量：想象、分享、爱、一次转发，意味着您正在向世界寄出一份礼物，内含：未来美好的想象，充实珍贵的分享和诚挚无私的爱！通过您的转发加入思和会的朋友，将会获得5积分，同时您也将获得50积分奖励\n3、积分是什么\n积分是您学习路上的“智慧”，详情请阅读【积分规则】，您懂的！";
        [_contentLabel setText:content lineSpacing:5];
        _contentLabel.frame = CGRectMake(15, 83, SCREENWIDTH-30,[_contentLabel getHeightLineWithString:content withWidth:SCREENWIDTH-30 withFont:[UIFont systemFontOfSize:14] lineSpacing:5]);
    }
    return _contentLabel;
}
-(void)pressBtn:(UIButton*)sender{
    self.changeBlock(sender.selected);
}
+(CGFloat)getHeight{
    CGFloat height = 113;
    UILabel *label = [[UILabel alloc]init];
    NSString*content = @"1、如何转发\n您可以使用本页右上角的“转发”键，将突破分享至微信朋友或朋友圈。\n2、为何要转发\n据说，上帝赐予人类三种力量：想象、分享、爱、一次转发，意味着您正在向世界寄出一份礼物，内含：未来美好的想象，充实珍贵的分享和诚挚无私的爱！通过您的转发加入思和会的朋友，将会获得5积分，同时您也将获得50积分奖励\n3、积分是什么\n积分是您学习路上的“智慧”，详情请阅读【积分规则】，您懂的！";
    [label setText:content lineSpacing:5];
  height += [label getHeightLineWithString:content withWidth:SCREENWIDTH-30 withFont:[UIFont systemFontOfSize:14] lineSpacing:5];
    
    return height;
}
@end
