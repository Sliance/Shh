//
//  CommentCell.m
//  Shh
//
//  Created by dnaer7 on 2018/11/7.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = DSColorFromHex(0xFAFAFA);
    }
    return _bgView;
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
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.nameLabel];
        [self.bgView addSubview:self.contentLabel];
        [self.bgView addSubview:self.dateLabel];
        [self.bgView addSubview:self.commentBtn];
    }
    return self;
}


-(void)setModel:(BeCommentModel *)model{
    _model = model;
    self.nameLabel.text = [NSString stringWithFormat:@"%@回复：%@",model.memberNickname,model.beCommentMemberNickname];
    self.nameLabel.frame = CGRectMake(15, 15, SCREENWIDTH-90-35,12);

    [self.contentLabel setText:model.commentContent lineSpacing:5];
    self.contentLabel.frame = CGRectMake(15, self.nameLabel.ctBottom+15, SCREENWIDTH-90-35, [self.contentLabel getHeightLineWithString:model.commentContent withWidth:SCREENWIDTH-125 withFont:[UIFont systemFontOfSize:14]lineSpacing:5]);
    self.dateLabel.frame = CGRectMake(15, self.contentLabel.ctBottom+15, SCREENWIDTH/2, 14);
    self.commentBtn.frame = CGRectMake(SCREENWIDTH-90-35, self.contentLabel.ctBottom+15, 20, 20);
    self.dateLabel.text = [NSDate cStringFromTimestamp:model.systemCreateTime Formatter:@"yyyy年MM月dd日"];
    self.bgView.frame = CGRectMake(70, 0, SCREENWIDTH-90, self.contentLabel.frame.size.height+80);
}
+(CGFloat)getCellHeight:(BeCommentModel *)model{
    UILabel *label = [[UILabel alloc]init];
    CGFloat contHeight = [label getHeightLineWithString:model.commentContent withWidth:SCREENWIDTH-90-35 withFont:[UIFont systemFontOfSize:14]lineSpacing:5];
    CGFloat height = contHeight+80;
    return height;
}
@end
