//
//  JYSOneBigImageTableViewCell.m
//  IngeniousNews
//
//  Created by 姜雨生 on 16/2/27.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSOneBigImageTableViewCell.h"
#import "JYSTools.h"
#import <UIImageView+WebCache.h>
/** 图片与文字以及边线的间距*/
#define ONEBIGIMAGESPACE 10

/** 图片占据Cell高度的比例*/
#define BIGIMAGESCALE 0.65

@implementation JYSOneBigImageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    
    self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(ONEBIGIMAGESPACE, ONEBIGIMAGESPACE, UISCREENWIDTH-2*ONEBIGIMAGESPACE, ONEBIGIMAGECELLHEIGHT*BIGIMAGESCALE)];
    [self addSubview:self.titleImage];
    
    self.titleLable = [JYSTools titleLableWithFrame:CGRectMake(ONEBIGIMAGESPACE, ONEBIGIMAGECELLHEIGHT*BIGIMAGESCALE+ONEBIGIMAGESPACE*1.5, UISCREENWIDTH-2*ONEBIGIMAGESPACE, 20)];
    [self addSubview:self.titleLable];
    
    self.digestLable = [JYSTools digestLableWithFrame:CGRectMake(ONEBIGIMAGESPACE, ONEBIGIMAGECELLHEIGHT*BIGIMAGESCALE+ONEBIGIMAGESPACE*1.5+25, UISCREENWIDTH-2*ONEBIGIMAGESPACE, 30)];
    [self addSubview:self.digestLable];
    
    self.replyCount = [JYSTools replyCountLableWithFrame:CGRectMake(0, ONEBIGIMAGECELLHEIGHT*BIGIMAGESCALE+ONEBIGIMAGESPACE*1.5+45, 0, 20)];
    [self addSubview:self.replyCount];
}


-(void)getDataWithModel:(id)model{
    
    JYSNewsModel *newsModel = (JYSNewsModel*)model;
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] placeholderImage:nil];
    
    self.titleLable.text = newsModel.title;
    
    self.digestLable.text = newsModel.digest;
    
    [JYSTools replyCountLableWidth:newsModel.replyCount Height:20 font:12 view:self.replyCount];
    
}

@end
