//
//  ViewController.m
//  AudioTextPlayer
//
//  Created by ju on 2017/3/16.
//  Copyright © 2017年 hu. All rights reserved.
//

#import "ViewController.h"
#import "AudioPlayerTextMangager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[AudioPlayerTextMangager sharedInstance] audioPlayer:@"测试一个文字语音"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
