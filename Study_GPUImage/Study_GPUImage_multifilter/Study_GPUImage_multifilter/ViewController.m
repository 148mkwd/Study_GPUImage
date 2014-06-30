//
//  ViewController.m
//  Study_GPUImage_multifilter
//
//  Created by 和田眞紀 on 2014/06/20.
//  Copyright (c) 2014年 和田眞紀. All rights reserved.
//

#import "ViewController.h"
#import <GPUIMage/GPUImage.h>

@interface ViewController ()

@property (nonatomic) GPUImagePicture *sourcePicture ;
@property (nonatomic) GPUImageFilterGroup *filterGroup ;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // フィルタ処理を実行する
    [self startFiltering] ;
}

- (void)startFiltering
{
    // self.viewをGPUImageViewにキャストする
    GPUImageView *view = (GPUImageView *)self.view ;
    
    // 画像を読み込み、GPUImagePictureインスタンスを生成する
    self.sourcePicture = [[GPUImagePicture alloc]
                          initWithImage:[UIImage imageNamed:@"ensoku.jpg"]
                          smoothlyScaleOutput:YES] ;
    
    // フィルタグループであるGPUImageFilterGroupインスタンスを生成する
    self.filterGroup = [GPUImageFilterGroup new] ;
    
    // スケッチ風フィルタを用意してフィルタグループに追加する
    GPUImageSketchFilter *sketchFilter = [GPUImageSketchFilter new] ;
   [self.filterGroup addFilter:sketchFilter] ;
    
    //セピアフィルタを用意してフィルタグループに追加する
    GPUImageSepiaFilter *sepiaFilter = [GPUImageSepiaFilter new] ;
    [self.filterGroup addFilter:sepiaFilter] ;
    
    // フィルタの構成を設定する
    // ここではスケッチ風フィルタ->セピアフィルタとする
    [sketchFilter addTarget:sepiaFilter] ;
//    [sepiaFilter addTarget:sketchFilter] ;
    
    // フィルタグループでオリジナルの画像を保存するフィル他を設定する
    self.filterGroup.initialFilters = @[sketchFilter] ;
    // 最後に適用するフィルタを設定する
    self.filterGroup.terminalFilter = sepiaFilter ;
    
    [self.sourcePicture addTarget:self.filterGroup] ;
    
    // フィル他処理結果をviewに表示するように設定する
    [self.filterGroup addTarget:view] ;
    
    // フィルタ処理を実行する
    [self.sourcePicture processImage] ;
    
}

//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

@end
