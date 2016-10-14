//
//  InfoViewController.m
//  FFmpegDemo
//
//  Created by SONGQG on 2016/10/14.
//  Copyright © 2016年 思源. All rights reserved.
//

#import "InfoViewController.h"
#include "avcodec.h"
#include "avformat.h"
#include "avfilter.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"see the console log";
    
    
    NSLog(@"Configure configuration:");
    av_register_all();
    printf("%s\n", avcodec_configuration());
    
    NSLog(@"Protocol configuration:");
    char info[40000]={0};
    struct URLProtocol *pup = NULL;
    //Input
    struct URLProtocol **p_temp = &pup;
    avio_enum_protocols((void **)p_temp, 0);
    while ((*p_temp) != NULL){
        sprintf(info, "%s[In ][%s]\n", info, avio_enum_protocols((void **)p_temp, 0));
    }
    pup = NULL;
    //Output
    avio_enum_protocols((void **)p_temp, 1);
    while ((*p_temp) != NULL){
        sprintf(info, "%s[Out][%s]\n", info, avio_enum_protocols((void **)p_temp, 1));
    }
    printf("%s\n", info);
    
    
    NSLog(@"AVFormat configuration:");
    char format_info[40000] = { 0 };
    AVInputFormat *if_temp = av_iformat_next(NULL);
    AVOutputFormat *of_temp = av_oformat_next(NULL);
    //Input
    while(if_temp!=NULL){
        sprintf(format_info, "%s[In ]%s\n", format_info, if_temp->name);
        if_temp=if_temp->next;
    }
    //Output
    while (of_temp != NULL){
        sprintf(format_info, "%s[Out]%s\n", format_info, of_temp->name);
        of_temp = of_temp->next;
    }
    printf("%s\n", format_info);
    
    
    NSLog(@"AVCodec configuration:");
    char avcodec_info[40000] = { 0 };
    AVCodec *c_temp = av_codec_next(NULL);
    
    while(c_temp!=NULL){
        if (c_temp->decode!=NULL){
            sprintf(avcodec_info, "%s[Dec]", avcodec_info);
        }
        else{
            sprintf(avcodec_info, "%s[Enc]", avcodec_info);
        }
        switch (c_temp->type){
            case AVMEDIA_TYPE_VIDEO:
                sprintf(avcodec_info, "%s[Video]", avcodec_info);
                break;
            case AVMEDIA_TYPE_AUDIO:
                sprintf(avcodec_info, "%s[Audio]", avcodec_info);
                break;
            default:
                sprintf(avcodec_info, "%s[Other]", avcodec_info);
                break;
        }
        sprintf(avcodec_info, "%s%s\n", avcodec_info, c_temp->name);
        c_temp=c_temp->next;
    }
    printf("%s", avcodec_info);
    
    NSLog(@"AVFilter configuration:");
    char filter_info[40000] = {0};
    avfilter_register_all();
    AVFilter *f_temp = (AVFilter *)avfilter_next(NULL);
    while (f_temp != NULL){
        sprintf(filter_info, "%s[%s]\n", filter_info, f_temp->name);
        f_temp = (AVFilter *)avfilter_next(f_temp);
    }
    printf("%s\n", filter_info);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
