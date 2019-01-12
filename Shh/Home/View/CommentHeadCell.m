//
//  CommentHeadCell.m
//  Shh
//
//  Created by dnaer7 on 2018/11/7.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "CommentHeadCell.h"

@implementation CommentHeadCell

-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        [_headImage.layer setCornerRadius:20];
        [_headImage.layer setMasksToBounds:YES];
        
    }
    return _headImage;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = DSColorFromHex(0x787878);
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = DSColorFromHex(0x464646);
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _contentLabel;
}
-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.textColor = DSColorFromHex(0xB4B4B4);
        _dateLabel.font = [UIFont systemFontOfSize:12];
        _dateLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _dateLabel;
}
-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = DSColorFromHex(0xE6E6E6);
    }
    return _lineLabel;
}
-(UIButton *)zanBtn{
    if (!_zanBtn) {
        _zanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_zanBtn setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
        [_zanBtn setTitleColor:DSColorFromHex(0xB4B4B4) forState:UIControlStateNormal];
        [_zanBtn setImage:[UIImage imageNamed:@"dianzan_selected"] forState:UIControlStateSelected];
        [_zanBtn setTitleColor:DSColorFromHex(0x787878) forState:UIControlStateNormal];
        _zanBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _zanBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [_zanBtn addTarget:self action:@selector(pressZan:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _zanBtn;
}
-(UIButton *)commentBtn{
    if (!_commentBtn) {
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        [_commentBtn setTitleColor:DSColorFromHex(0xB4B4B4) forState:UIControlStateNormal];
        [_commentBtn addTarget:self action:@selector(pressComment:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentBtn;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.lineLabel];
        [self addSubview:self.headImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.dateLabel];
        [self addSubview:self.zanBtn];
        [self addSubview:self.commentBtn];
        self.lineLabel.frame = CGRectMake(15, 10, SCREENWIDTH-30, 1);
        self.headImage.frame = CGRectMake(15, 25, 40, 40);
        self.nameLabel.frame = CGRectMake(self.headImage.ctRight+15, 14+self.headImage.ctTop, SCREENWIDTH-80, 12);
    }
    return self;
}

-(void)setModel:(CommentListRes *)model{
    _model = model;
    NSString *url = [NSString stringWithFormat:@"%@%@",DPHOST,model.memberAvatarPath];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"mine"]];
    self.nameLabel.text = model.memberNickname;
    [self.contentLabel setText:model.commentContent lineSpacing:5];
    self.contentLabel.frame = CGRectMake(self.headImage.ctRight+15, self.headImage.ctBottom, SCREENWIDTH-90, [self.contentLabel getHeightLineWithString:model.commentContent withWidth:SCREENWIDTH-90 withFont:[UIFont systemFontOfSize:14]lineSpacing:5]);
    self.dateLabel.frame = CGRectMake(self.headImage.ctRight+15, self.contentLabel.ctBottom+15, SCREENWIDTH/2, 14);
    self.zanBtn.frame = CGRectMake(SCREENWIDTH-100, self.contentLabel.ctBottom, 60, 40);
    self.commentBtn.frame = CGRectMake(SCREENWIDTH-35, self.contentLabel.ctBottom+2, 20, 40);
    self.dateLabel.text = [NSDate cStringFromTimestamp:model.systemCreateTime Formatter:@"yyyy年MM月dd日"];
    [self.zanBtn setTitle:model.commentLikeCount forState:UIControlStateNormal];
    self.zanBtn.selected = model.memberIsLike;
}
+(CGFloat)getCellHeight:(CommentListRes *)model{
    UILabel *label = [[UILabel alloc]init];
    CGFloat contHeight = [label getHeightLineWithString:model.commentContent withWidth:SCREENWIDTH-90 withFont:[UIFont systemFontOfSize:14]lineSpacing:5];
    CGFloat height = contHeight+55+50;
    return height;
}
-(void)pressZan:(UIButton*)sender{
    self.zanBlock(sender.selected);
}
-(void)pressComment:(UIButton*)sender{
    
    self.commentBlock(_model);
}
@end
