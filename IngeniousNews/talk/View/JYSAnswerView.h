//
//  JYSAnswerView.h
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/9.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYSTalkDetailAnswerModel.h"
@interface JYSAnswerView : UIView

@property(nonatomic,retain)UIImageView *answerUserImage;

@property(nonatomic,retain)UILabel *answerName;

@property(nonatomic,retain)UILabel *answer;

@property(nonatomic,retain)UILabel *answerTime;


-(void)getDataWithModel:(JYSTalkDetailAnswerModel*)model;
@end
