//
//  FileInfoViewController.m
//  YiLiao
//
//  Created by Mega on 16/3/24.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import "FileInfoViewController.h"
#import "FileManager.h"

@interface FileInfoViewController ()

@end

@implementation FileInfoViewController


- (void)viewDidLoad {
    [super viewDidLoad];

//    展示文件 首先要知道它是什么格式的

    int type = [self.infoModel.type intValue];
    switch (type) {
        case 0:
        {
//            pdf
            [self showPDFOrDoc];

        }
            break;
        case 1:
//            mp3
            [self showMP3];
            break;
        case 2:
//            mp4
            [self showMp4];
            break;
        case 3:
            //            doc
             [self showPDFOrDoc];
            break;
        case 4:
            //            jpg
            [self showJpg];
            break;
        default:
            break;
    }

}

//pdf
-(void)showPDFOrDoc
{

    UIWebView *web = [[UIWebView alloc]init];
    web.frame = CGRectMake(0, 64, MyWidth, MyHight);

//    url 可以是本地的文件路径
    NSURL *url = [NSURL fileURLWithPath:[self getFilePath]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [web loadRequest:request];
    [self.view addSubview:web];

}

-(void)showMP3
{
    NSURL *url = [NSURL fileURLWithPath:[self getFilePath]];
    NSError *error = nil;
    _audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
//    直接播放
    [_audioPlayer play];

}

-(void)showMp4
{
    NSURL *url = [NSURL fileURLWithPath:[self getFilePath]];

    _palyViewController = [[AVPlayerViewController alloc]init];
    _palyViewController.view.frame= CGRectMake(0, 64, MyWidth, MyHight);
    _palyViewController.player  =[AVPlayer playerWithURL:url];

    [self.view addSubview:_palyViewController.view];
    [_palyViewController.player play];

}

-(void)showJpg
{
//    NSURL *url = [NSURL fileURLWithPath:[self getFilePath]];
    
    UIImage *imge = [UIImage imageWithContentsOfFile:[self getFilePath]];
    UIImageView *imgeView = [[UIImageView alloc]initWithImage:imge];
    imgeView.frame = CGRectMake(0, 64, MyWidth, MyHight);
    [self.view addSubview:imgeView];

}

//找文件地址
-(NSString *)getFilePath{

    NSString *path = [[FileManager sharManager] downLoadFileWithUrl:self.infoModel];

    return path;

}




@end
