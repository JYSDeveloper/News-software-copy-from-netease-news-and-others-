//
//  JYSTalkDetailCell.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/9.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSTalkDetailCell.h"
@implementation JYSTalkDetailCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.814 alpha:1.000];
        self.questionView = [[JYSQuestionView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, 200)];
        self.questionView.backgroundColor  = [UIColor whiteColor];
        self.answerView = [[JYSAnswerView alloc]initWithFrame:CGRectMake(0, 200, UISCREENWIDTH, 200)];
        self.answerView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.questionView];
        [self.contentView addSubview:self.answerView];
    }
    return self;
    
}

-(void)getDataWithModel:(id)model{
    
    JYSTalkDetailModel *detailModel =(JYSTalkDetailModel*)model;
    
    [self.questionView getDataWithModel:detailModel.questionModel];
    [self.answerView getDataWithModel:detailModel.answerModel];
    self.answerView.frame = CGRectMake(0, self.questionView.frame.size.height, UISCREENWIDTH, self.answerView.answerTime.frame.size.height+self.answerView.answerTime.frame.origin.y);
}

@end
