//
//  AudioPlayController.h
//  Shh
//
//  Created by zhangshu on 2018/12/10.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseViewController.h"
#import "HgMusicBottomView.h"
#import "HgMusicPlayerManager.h"
#import "CourseListModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface AudioPlayController : BaseViewController
@property(nonatomic, strong) HgMusicBottomView *bottomView;
-(void) playStateRecover ;
@property(nonatomic,strong)NSString*url;
@property(nonatomic,strong)CourseListModel *audioRes;
@end

NS_ASSUME_NONNULL_END
