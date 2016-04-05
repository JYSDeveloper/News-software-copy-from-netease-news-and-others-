//
//  JYSCityNormalTableViewCell.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/5.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSCityNormalTableViewCell.h"
#import "JYSTools.h"
#import "JYSCityNewsModel.h"

@implementation JYSCityNormalTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    
    self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, UISCREENWIDTH/3, LISTENCELLHEIGHT - 2*10)];
    [self.contentView addSubview:self.titleImage];
    
    self.titleLable = [JYSTools titleLableWithFrame:CGRectMake(2*10 + UISCREENWIDTH/3, 10, UISCREENWIDTH*0.6, LISTENCELLHEIGHT*2/3)];
    self.titleLable.font = [UIFont systemFontOfSize:18];
    self.titleLable.numberOfLines = 0;
    [self.contentView addSubview:self.titleLable];
    
    self.repeatLable = [JYSTools replyCountLableWithFrame:CGRectMake(20+UISCREENWIDTH/3, 10+LISTENCELLHEIGHT*2/3, 0, 20)];
    [self.contentView addSubview:self.repeatLable];
    
    self.dateLable = [[UILabel alloc]initWithFrame:CGRectMake(20+UISCREENWIDTH/3, 10+LISTENCELLHEIGHT*2/3, 100, 20)];
    self.dateLable.font = [UIFont systemFontOfSize:12];
    self.dateLable.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.dateLable];
    
}

-(void)getDataWithModel:(id)model{
    
    JYSCityNewsModel *cityModel = (JYSCityNewsModel*)model;
    self.titleLable.text = cityModel.title;
    self.dateLable.text = [cityModel.updateTime substringToIndex:10];
    [JYSTools replyCountLableWidth:cityModel.comments Height:20 font:12 view:self.repeatLable];
    if (![cityModel.thumbnail  isEqual: @""]) {
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:cityModel.thumbnail] placeholderImage:nil];
    }
    else{
        
        [self.titleImage removeFromSuperview];
        self.titleLable.frame = CGRectMake(10, 10, UISCREENWIDTH-20, LISTENCELLHEIGHT*2/3);
        self.dateLable.frame = CGRectMake(10, 10+LISTENCELLHEIGHT*2/3, 100, 20);
    }
}

@end
