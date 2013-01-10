//
//  BingoBoardViewController.m
//  Hottest100 Bingo
//
//  Created by Robert Wagstaff on 4/01/13.
//  Copyright (c) 2013 Robert Wagstaff. All rights reserved.
//


#import "BingoBoardViewController.h"
#import "BingoBoardView.h"


@interface BingoBoardViewController ()

@end

@implementation BingoBoardViewController

-(id)init {
    self = [super init];
    if (self) {
       
        self.view.backgroundColor = [UIColor redColor];
                
    }
    return self;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    BingoBoardView* mainBingoBoardView = [[BingoBoardView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    mainBingoBoardView.backgroundColor = [UIColor greenColor];
    mainBingoBoardView.alwaysBounceVertical = YES;
    [self.view addSubview:mainBingoBoardView];

}



@end
