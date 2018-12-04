//
//  PromoteQrFootView.h
//  Shh
//
//  Created by zhangshu on 2018/12/4.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PromoteQrFootView : BaseView
@property(nonatomic,strong)UIButton*titleBtn;
@property(nonatomic,strong)UILabel*contentLabel;
@property(nonatomic,copy)void (^changeBlock)(BOOL);
+(CGFloat)getHeight;

@end

NS_ASSUME_NONNULL_END
