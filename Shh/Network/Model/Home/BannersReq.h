//
//  BannersReq.h
//  Shh
//
//  Created by dnaer7 on 2018/10/19.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseModelReq.h"



@interface BannersReq : BaseModelReq
///展示终端
@property(nonatomic,copy)NSString *appOrPc;
///banner位置(wxIndex 首页；wxCourse、课程；wxService 服务)
@property(nonatomic,copy)NSString *bannerLocation;


@end


