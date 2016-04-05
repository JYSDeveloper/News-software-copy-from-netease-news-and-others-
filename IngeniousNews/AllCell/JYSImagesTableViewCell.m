//
//  JYSImagesTableViewCell.m
//  IngeniousNews
//
//  Created by 姜雨生 on 16/2/29.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSImagesTableViewCell.h"
#import <UIImageView+WebCache.h>
#define IMAGESPACE 10
#define IMAGEWIDTH (UISCREENWIDTH-IMAGESPACE*4)/3

@implementation JYSImagesTableViewCell

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
    
    self.titleLable = [JYSTools titleLableWithFrame:CGRectMake(IMAGESPACE, IMAGESPACE, 300, IMAGESCELLHEIGHT/6)];
    [self addSubview:self.titleLable];
    
    self.replyCountLable = [JYSTools replyCountLableWithFrame:CGRectMake(0, IMAGESPACE*1.5, 0, IMAGESCELLHEIGHT/6)];
    [self addSubview:self.replyCountLable];
    
    self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(IMAGESPACE, IMAGESPACE*2+IMAGESCELLHEIGHT/6, IMAGEWIDTH, IMAGESCELLHEIGHT-IMAGESPACE*3-IMAGESCELLHEIGHT/6)];
    [self addSubview:self.titleImage];
    
    self.imageCenter = [[UIImageView alloc]initWithFrame:CGRectMake(IMAGESPACE*2+IMAGEWIDTH, IMAGESPACE*2+IMAGESCELLHEIGHT/6, IMAGEWIDTH, IMAGESCELLHEIGHT-IMAGESPACE*3-IMAGESCELLHEIGHT/6)];
    [self addSubview:self.imageCenter];
    
    self.imageRight = [[UIImageView alloc]initWithFrame:CGRectMake(IMAGESPACE*3+IMAGEWIDTH*2, IMAGESPACE*2+IMAGESCELLHEIGHT/6, IMAGEWIDTH, IMAGESCELLHEIGHT-IMAGESPACE*3-IMAGESCELLHEIGHT/6)];
    [self addSubview:self.imageRight];
    
    
}



-(void)getDataWithModel:(id)model{
    
    JYSNewsModel *newsModel = (JYSNewsModel*)model;
    
    self.titleLable.text = newsModel.title;
    
    [JYSTools replyCountLableWidth:newsModel.replyCount Height:IMAGESCELLHEIGHT/6 font:12 view:self.replyCountLable];
    
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] placeholderImage:nil];
    
    [self.imageCenter sd_setImageWithURL:[NSURL URLWithString:newsModel.imgextra[0][@"imgsrc"]] placeholderImage:nil];
    
    [self.imageRight sd_setImageWithURL:[NSURL URLWithString:newsModel.imgextra[1][@"imgsrc"]] placeholderImage:nil];
    
}


@end
