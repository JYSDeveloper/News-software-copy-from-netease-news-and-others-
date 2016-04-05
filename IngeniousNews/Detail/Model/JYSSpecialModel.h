//
//  JYSSpecialModel.h
//  IngeniousNews
//
//  Created by 姜雨生 on 16/3/1.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYSSpecialModel : NSObject

@property(nonatomic,retain)NSNumber *index;
@property(nonatomic,retain)NSMutableArray *news;

@property(nonatomic,copy)NSString *tname;
@property(nonatomic,copy)NSString *shortname;

@property(nonatomic,copy)NSString *type;

+(instancetype)specialModelWithDic:(NSDictionary*)dic;

@end
