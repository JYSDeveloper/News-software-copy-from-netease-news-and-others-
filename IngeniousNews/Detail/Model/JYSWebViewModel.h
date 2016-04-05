//
//  JYSWebViewModel.h
//  IngeniousNews
//
//  Created by 姜雨生 on 16/2/29.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYSWebViewModel : NSObject

typedef NS_ENUM(NSUInteger, WebModelType) {
    
    firstType = 0,
    secondType
};


/** 新闻的标题*/
@property(nonatomic,copy)NSString *title;

/** 新闻的发布时间*/
@property(nonatomic,copy)NSString *ptime;

/** 新闻内容*/
@property(nonatomic,copy)NSString *body;

/** 新闻配图*/
@property(nonatomic,retain)NSArray *img;

/** 多图页*/
@property(nonatomic,copy) NSString *href;




+(instancetype)webViewModelWithDic:(NSDictionary*)dic withType:(WebModelType)Type;

@end
