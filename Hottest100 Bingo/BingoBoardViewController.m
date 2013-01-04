//
//  BingoBoardViewController.m
//  Hottest100 Bingo
//
//  Created by Robert Wagstaff on 4/01/13.
//  Copyright (c) 2013 Robert Wagstaff. All rights reserved.
//
#define NUMBER_OF_TILES 16
#define BINGO_MARGIN 8

#import "BingoBoardViewController.h"
#import "BingoTile.h"

@interface BingoBoardViewController ()

@end

@implementation BingoBoardViewController

-(id)init {
    self = [super init];;
    if (self) {
        self.view.backgroundColor = [UIColor redColor];
    }
    return self;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for (int i = 0; i < NUMBER_OF_TILES; i++) {
        
        int tableXPos =((fmodf(i, 4)*TILE_WIDTH) + BINGO_MARGIN);
        int tableYPos =((floor(i / 4)*TILE_HEIGHT) + BINGO_MARGIN);
        BingoTile *bingoTile = [[BingoTile alloc] initWithFrame:CGRectMake(tableXPos, tableYPos, TILE_WIDTH, TILE_HEIGHT)];
        [self.view addSubview:bingoTile];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
