//
//  JYSQuestionView.h
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/9.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYSTalkDetailQuestionModel.h"
@interface JYSQuestionView : UIView

@property(nonatomic,retain)UIImageView *questionUserImage;

@property(nonatomic,retain)UILabel *questionName;

@property(nonatomic,retain)UILabel *questionLable;



-(void)getDataWithModel:(JYSTalkDetailQuestionModel*)model;

@end
