//
//  MemberShipCell.h
//  Shh
//
//  Created by zhangshu on 2018/12/3.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MemberShipCell : BaseTableViewCell
<UITextFieldDelegate>

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UITextField *contentFiled;
@property(nonatomic,strong)UIImageView *headImage;

@end

NS_ASSUME_NONNULL_END
