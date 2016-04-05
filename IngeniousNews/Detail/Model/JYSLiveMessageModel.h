//
//  JYSLiveMessageModel.h
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/12.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYSLiveMessageModel : NSObject
/** id*/
@property(nonatomic,copy)NSString *ID;
/** 时间*/
@property(nonatomic,copy)NSString *time;
/** 评论员名字*/
@property(nonatomic,copy)NSString *commentatorName;
/** 评论员头像*/
@property(nonatomic,copy)NSString *commentatorImgUrl;
/** 评论内容*/
@property(nonatomic,copy)NSString *msgContent;
/** 图片数组*/
@property(nonatomic,retain)NSMutableArray *images;
/** 分组信息*/
@property(nonatomic,copy)NSString *section;

+(instancetype)liveMessageModelWithDic:(NSDictionary*)dic;


@end
