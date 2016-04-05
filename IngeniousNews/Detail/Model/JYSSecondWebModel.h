//
//  JYSSecondWebModel.h
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/4.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYSSecondWebModel : NSObject

@property(nonatomic,copy)NSString *content;

@property(nonatomic,retain)NSMutableArray *imageArr;

+(instancetype)secondWebModelWithDic:(NSDictionary*)dic;


@end
