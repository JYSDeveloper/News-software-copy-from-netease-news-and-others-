//
//  JYSTalkDetailCell.h
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/9.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSBaseTableViewCell.h"
#import "JYSAnswerView.h"
#import "JYSQuestionView.h"
#import "JYSTalkDetailModel.h"
@interface JYSTalkDetailCell : JYSBaseTableViewCell

@property(nonatomic,retain)JYSAnswerView *answerView;

@property(nonatomic,retain)JYSQuestionView *questionView;



@end
