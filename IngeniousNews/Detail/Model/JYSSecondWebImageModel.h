//
//  JYSSecondWebImageModel.h
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/4.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYSSecondWebImageModel : NSObject

@property(nonatomic,copy)NSString *w;

@property(nonatomic,copy)NSString *h;

@property(nonatomic,copy)NSString *url;

+(instancetype)ModelWithDic:(NSDictionary*)dic;

@end
