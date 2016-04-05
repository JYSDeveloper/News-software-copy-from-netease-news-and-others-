//
//  JYSListenDetailViewController.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/3.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSListenDetailViewController.h"
#import "MHNetWorkTask.h"
#import <UIImageView+WebCache.h>
#import <AVFoundation/AVFoundation.h>
#import "JYSListenDetailView.h"
#define PLAYVIEWHEIGHT 100
#define SOUNDTAG 1000
#define TIMETAG 1001
@interface JYSListenDetailViewController ()

@property(nonatomic,retain)JYSListenDetailModel *detailModel;


@property(nonatomic,retain)JYSListenDetailView *dataView;

@property(nonatomic,retain)UIView *playerControl;

@property(nonatomic,retain)AVPlayer *playMP3;

@property(nonatomic,retain)UISlider *timeSlider;

@property(nonatomic,retain)UISlider *soundSlider;

@property(nonatomic,retain)UIButton *playBtn;

@property(nonatomic,retain)UILabel *playTimeLabel;

@property(nonatomic,retain)UILabel *totalTimeLabel;

@property(nonatomic,retain)UIButton *repeatBtn;

@property(nonatomic,assign)CGFloat totalDuration;
@end

@implementation JYSListenDetailViewController

-(void)viewWillDisappear:(BOOL)animated{
    
    [self.playMP3 pause];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataView = [[JYSListenDetailView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.dataView];
    [self getData];
    [self creatPlayer];
    [self playView];
    [self.playMP3 play];
    
    
}

-(void)getData{
    
    NSString *url = @"http://admin.tingwen.me/index.php/api/interface/postinfo";
    [MHNetWorkTask postWithURL:url withBody:[NSString stringWithFormat:@"post_id=%@",self.model.ID] withBodyType:BodyTypeString withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        self.detailModel = [JYSListenDetailModel listenDetailModelWithDic:[result objectForKey:@"results"]];
    
        [self.dataView reloadData:self.detailModel];
        
    } withFail:^(NSError *error) {
        //[self getData];
    }];

    
}

-(void)playView{
    
    
    self.playerControl = [[UIView alloc]initWithFrame:CGRectMake(0, UISCREENHEIGHT-PLAYVIEWHEIGHT, UISCREENWIDTH, PLAYVIEWHEIGHT)];
    self.playerControl.backgroundColor = [UIColor colorWithWhite:0.785 alpha:1.000];
    [self.view addSubview:self.playerControl];
    
    self.timeSlider = [[UISlider alloc]initWithFrame:CGRectMake(20+UISCREENWIDTH/8, 10, UISCREENWIDTH*0.6, PLAYVIEWHEIGHT/5)];
    self.timeSlider.maximumValue = 1.0;
    self.timeSlider.minimumValue = 0.0;
    self.timeSlider.value = 0.0;
    self.timeSlider.tag = TIMETAG;
    self.timeSlider.minimumTrackTintColor = [UIColor colorWithRed:0.268 green:0.478 blue:1.000 alpha:1.000];
    self.timeSlider.maximumTrackTintColor = [UIColor colorWithRed:0.036 green:1.000 blue:0.881 alpha:1.000];
    [self.timeSlider addTarget:self action:@selector(doChangeProgress:) forControlEvents:UIControlEventValueChanged];
    [self.playerControl addSubview:self.timeSlider];

    self.playTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, UISCREENWIDTH*0.15, PLAYVIEWHEIGHT/5)];
    self.playTimeLabel.font = [UIFont systemFontOfSize:15];
    self.playTimeLabel.text = @"00:00";
    [self.playerControl addSubview:self.playTimeLabel];
    
    self.totalTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*0.9-20, 10, UISCREENWIDTH*0.15, PLAYVIEWHEIGHT/5)];
    self.totalTimeLabel.font = [UIFont systemFontOfSize:15];
    self.totalTimeLabel.text = @"00:00";
    [self.playerControl addSubview:self.totalTimeLabel];
    
    self.playBtn = [[UIButton alloc]initWithFrame:CGRectMake(UISCREENWIDTH/2-25, 20+PLAYVIEWHEIGHT/5, 50, 50)];
    [self.playBtn setImage:[UIImage imageNamed:@"start"] forState:UIControlStateSelected];
    [self.playBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    [self.playBtn addTarget:self action:@selector(playBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.playerControl addSubview:self.playBtn];
    
    self.repeatBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, PLAYVIEWHEIGHT/3, PLAYVIEWHEIGHT/3)];
    self.repeatBtn.center = CGPointMake(10+PLAYVIEWHEIGHT/3, PLAYVIEWHEIGHT/3*2);
    [self.repeatBtn setImage:[UIImage imageNamed:@"repeat"] forState:UIControlStateNormal];
    [self.repeatBtn addTarget:self action:@selector(repeatBtnAciont) forControlEvents:UIControlEventTouchUpInside];
    [self.playerControl addSubview:self.repeatBtn];
    
    self.soundSlider = [[UISlider alloc]initWithFrame:CGRectMake(UISCREENWIDTH/2+50, PLAYVIEWHEIGHT/2, UISCREENWIDTH/2-50-10, PLAYVIEWHEIGHT/5)];
    self.soundSlider.minimumValue = 0.0;
    self.soundSlider.maximumValue = 100.0;
    self.soundSlider.value = 50.0;
    self.soundSlider.tag = SOUNDTAG;
    self.soundSlider.maximumTrackTintColor = [UIColor colorWithRed:0.036 green:1.000 blue:0.881 alpha:1.000];
    self.soundSlider.minimumTrackTintColor = [UIColor colorWithRed:0.268 green:0.478 blue:1.000 alpha:1.000];
    [self.soundSlider addTarget:self action:@selector(doChangeProgress:) forControlEvents:UIControlEventValueChanged];
    [self.playerControl addSubview:self.soundSlider];
    
    
    
}
-(void)creatPlayer{

    
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:self.model.post_mp]];
    self.playMP3 = [[AVPlayer alloc]initWithPlayerItem:item];
    
    __weak JYSListenDetailViewController *weakVC = self;
    __weak AVPlayer *weakPlayer = self.playMP3;
    [self.playMP3 addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        //当前的播放时间
        if (weakPlayer) {
             
            float currentTime = weakPlayer.currentItem.currentTime.value / weakPlayer.currentItem.currentTime.timescale;
            weakVC.timeSlider.value = currentTime;
            weakVC.playTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",(int)currentTime/60,(int)currentTime%60];
            
            if (weakVC.totalTimeLabel.text) {
                weakVC.timeSlider.maximumValue = self.playMP3.currentItem.duration.value / self.playMP3.currentItem.duration.timescale;
                weakVC.totalTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",(int)self.timeSlider.maximumValue/60,(int)self.timeSlider.maximumValue%60];
            }
        }
    }];

}

-(void)repeatBtnAciont{
    
    [self.playMP3 seekToTime:CMTimeMake(0, 1)];
    
}

-(void)doChangeProgress:(UISlider*)sender{
    
    if(sender.tag == TIMETAG){
        
        [self.playMP3 seekToTime:CMTimeMake(self.timeSlider.value, 1)];
        
    }
    else{
      //  NSLog(@"sound:%.2f",self.soundSlider.value);
        
    }
    
    
}
-(void)playBtnAction:(UIButton*)sender{
    
    if (!sender.selected) {
        [self.playMP3 pause];
        
    }else{
        [self.playMP3 play];
    }
    sender.selected = !sender.selected;
    
}




-(NSTimeInterval)availableDuration{
    
    NSArray *loaderTimeRanges = [[self.playMP3 currentItem]loadedTimeRanges];
    CMTimeRange timeRange = [loaderTimeRanges.firstObject CMTimeRangeValue];
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durantionSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durantionSeconds;
    return result;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
