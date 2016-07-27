//
//  FileInfoViewController.h
//  YiLiao
//
//  Created by Mega on 16/3/24.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileListModel.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
@interface FileInfoViewController : UIViewController

//音频播放器
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;

@property (nonatomic,strong) MPMoviePlayerController *moviePlayer;
//需要进行适配

@property (nonatomic,strong) AVPlayerViewController *palyViewController;


@property (nonatomic,strong) FileInfoModel *infoModel;







@end
