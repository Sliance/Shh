//
//  CommentCell.h
//  Shh
//
//  Created by dnaer7 on 2018/11/7.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BeCommentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentCell : BaseTableViewCell
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *commentBtn;

@property (nonatomic, strong)BeCommentModel *model;
+(CGFloat)getCellHeight:(BeCommentModel *)model;

@end

NS_ASSUME_NONNULL_END
