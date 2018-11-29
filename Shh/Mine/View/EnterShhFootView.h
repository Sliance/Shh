//
//  EnterShhFootView.h
//  Shh
//
//  Created by zhangshu on 2018/11/29.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface EnterShhFootView : BaseView
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UIImageView *rightImage;
@property(nonatomic,strong)UILabel *line;
@property(nonatomic,strong)UILabel *leftline;
@property(nonatomic,strong)UILabel *rightline;
@property(nonatomic,strong)UIButton *applyBtn;
@property(nonatomic,copy)void (^appBlock)(void);
@end

NS_ASSUME_NONNULL_END
