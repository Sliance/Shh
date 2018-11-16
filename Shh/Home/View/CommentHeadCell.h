//
//  CommentHeadCell.h
//  Shh
//
//  Created by dnaer7 on 2018/11/7.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "CommentListRes.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentHeadCell : BaseView
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UIButton *zanBtn;
@property (nonatomic, strong) UIButton *commentBtn;

@property (nonatomic, strong)CommentListRes *model;

+(CGFloat)getCellHeight:(CommentListRes *)model;
@property(nonatomic,copy)void (^zanBlock)(BOOL);
@property(nonatomic,copy)void (^commentBlock)(CommentListRes *);

@end

NS_ASSUME_NONNULL_END
