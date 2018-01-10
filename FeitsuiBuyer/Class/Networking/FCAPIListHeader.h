//
//  FCAPIListHeader.h
//  FeitsuiBuyer
//
//  Created by JourneyYoung on 2017/12/22.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const BASE_URL = @"http://temp.cqquality.com";

static NSString * const SERVICE_SPECIAL_PREFERIENCE = @"/service/cheap/getCheapServiceInfo";

// 用户注册
static NSString * const USER_REGISTER = @"/api/users/register";

// 用户登录
static NSString * const USER_LOGIN = @"/api/users/login";

// 用户首页
static NSString * const USER_DATA = @"/api/users/index?token=";

// 刷新TOKEN
static NSString * const REFRESH_TOKEN = @"/api/users/refreshToken?token=";

// 完善用户信息
static NSString * const EDIT_USER_NAME = @"/api/users/edit?token=";

// 修改用户头像
static NSString * const EDIT_USER_LOGO = @"/api/users/logo?token=";

// 上传供应商营业执照或者身份证
static NSString * const USER_AGENT_UPLOAD = @"/api/users/agent/upload?token=";

// 申请成为供应商
static NSString * const USER_AGENT_ADD = @"/api/users/agent/add?token=";

// 获取所有文章
static NSString * const ARTICLES = @"/api/articles";

// 获取文章详情（通过文章ID）
static NSString * const ARTICLE_ID = @"/api/article/id";

// 获取所有文章分类
static NSString * const ARTICLES_CATS = @"/api/articles/cats";

// 获取分类文章（通过分类ID）
static NSString * const ARTICLES_CATS_ID = @"/api/article/cat/id";

/// 获取所有轮播图
static NSString *const GET_ALL_SLIDES   = @"/api/slides";

/// 获取所有品种
static NSString *const GET_ALL_CATS   = @"/api/cats";
