//
//  MineServiceApi.m
//  Shh
//
//  Created by zhangshu on 2018/11/28.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "MineServiceApi.h"

@implementation MineServiceApi
+ (instancetype)share {
    static MineServiceApi *global;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (global == nil) {
            global = [[MineServiceApi alloc] init];
        }
    });
    return global;
}

//登录
-(void)loginWithParam:(LoginReq *)req response:(responseModel)responseModel{
    NSDictionary *dic = [req mj_keyValues];
    
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:login_url Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    
                    responseModel(dicResponse);
                }
            }else {
                if (responseModel) {
                    responseModel(dicResponse);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///注册发送验证码
-(void)sendCodeWithParam:(LoginReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:send_code Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    
                    responseModel(dicResponse);
                }
            }else {
                if (responseModel) {
                    responseModel(dicResponse);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///注册
-(void)registerWithParam:(LoginReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:register_url Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    
                    responseModel(dicResponse);
                }
            }else {
                if (responseModel) {
                    responseModel(dicResponse);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///忘记密码发送验证码
-(void)forgetSendCodeWithParam:(LoginReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:send_code_forget Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    
                    responseModel(dicResponse);
                }
            }else {
                if (responseModel) {
                    responseModel(dicResponse);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///忘记密码
-(void)forgetPasswordWithParam:(LoginReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [dic  setValue:req.newsPassword forKey:@"newPassword"];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:forget_password Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    
                    responseModel(dicResponse);
                }
            }else {
                if (responseModel) {
                    responseModel(dicResponse);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///获取会员基本信息
-(void)getMenberInfoWithParam:(LoginReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:mine_info Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    MemberInfoRes *model = [MemberInfoRes mj_objectWithKeyValues:dicResponse[@"data"]];
                    responseModel(model);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///帮助列表
-(void)getHelpListWithParam:(LoginReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:help_list Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    NSArray *result = [HelpRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}///消息列表
-(void)getMessageListWithParam:(LoginReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:message_list Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    NSArray *result = [MessageRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}///历史记录
-(void)getHistoryListWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:history_list_url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    NSArray *result = [FreeListRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///我的购买
-(void)getOrderListWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:mine_purchse_url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    NSArray *result = [OrderRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///我的收藏
-(void)getCollectListWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:mine_collect_url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    NSArray *result = [CollectionRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///我的关注
-(void)getFollowListWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:mine_follow_url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    NSArray *result = [FollowRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///申请入驻提交审核
-(void)applyForWithParam:(ApplyForReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:apply_for_url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    
                    responseModel(dicResponse);
                }
            }else {
                if (responseModel) {
                    responseModel(dicResponse);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///加入思和会/研习社/总裁班
-(void)joinInWithParam:(ApplyForReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:join_in_url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    
                    responseModel(dicResponse);
                }
            }else {
                if (responseModel) {
                    responseModel(dicResponse);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}

///我关注的授课师
-(void)getTeacherInfoWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:teacher_url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    FollowRes *result = [FollowRes mj_objectWithKeyValues:dicResponse[@"data"]];
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///我关注的授课师的文章
-(void)getTeacherArticleWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:teacher_article_url Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    NSArray *result = [TodayListRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///我关注的授课师的课程
-(void)getTeacherCourseWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:teacher_course_list Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    NSArray *result = [FreeListRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///我关注的公司的服务
-(void)getCompanyServiceWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:company_service_url Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    NSArray *result = [ServiceListRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///我关注的公司
-(void)getCompanyInfoWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:company_url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    FollowRes *result = [FollowRes mj_objectWithKeyValues:dicResponse[@"data"]];
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///修改个人信息
-(void)changeMemberInfoWithParam:(MemberInfoRes *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:update_Info_url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    
                    responseModel(dicResponse);
                }
            }else {
                if (responseModel) {
                    responseModel(dicResponse);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///积分明细
-(void)getIntegralDetailWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:mine_Integral Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    NSArray *result = [IntegralRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///积分排行
-(void)getIntegralRankWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:rank_Integral Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    NSArray *result = [IntegralRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///勋章
-(void)getmMineMedalWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:mine_medal Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    NSArray *result = [MineMedalRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///我的任务
-(void)getmMineTaskWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:mine_task Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    NSArray *result = [IntegralRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"]];
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///签到
-(void)getSignInWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:sign_in Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    
                    responseModel(dicResponse);
                }
            }else {
                if (responseModel) {
                    responseModel(dicResponse);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
@end
