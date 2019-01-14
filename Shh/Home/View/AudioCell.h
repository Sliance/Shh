//
//  AudioCell.h
//  Shh
//
//  Created by dnaer7 on 2018/11/14.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CourseListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AudioCell : BaseTableViewCell
@property(nonatomic,strong)UIButton *playBtn;
@property(nonatomic,strong)UIButton *suoBtn;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong)CourseListModel*model;
@property(nonatomic,copy)void(^playBlock)(BOOL);
@property(nonatomic,copy)void(^audioBlock)(BOOL);
@end

NS_ASSUME_NONNULL_END
