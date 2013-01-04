//
//  BingoBoardViewController.m
//  Hottest100 Bingo
//
//  Created by Robert Wagstaff on 4/01/13.
//  Copyright (c) 2013 Robert Wagstaff. All rights reserved.
//
#define NUMBER_OF_TILES 16

#import "BingoBoardViewController.h"
#import "BingoTile.h"

@interface BingoBoardViewController ()

@end

@implementation BingoBoardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    BingoTile *bingoTile;
    for (int i = 0; i < NUMBER_OF_TILES; i++) {
        
        int tableXPos =((fmodf(i, 4)*TILE_WIDTH) + (TILE_WIDTH/2));
        int tableYPos =((floor(i / 4)*TILE_HEIGHT) + (TILE_HEIGHT/2));
        //int tableYPos =
        BingoTile *bingoTile = [[BingoTile alloc] initWithFrame:CGRectMake(tableXPos, tableYPos, TILE_WIDTH, TILE_HEIGHT)];
        [self.view addSubview:bingoTile];
    }
//    BingoTile *bingoTile = [[BingoTile alloc] initWithFrame:CGRectMake(TILE_WIDTH, TILE_HEIGHT, TILE_WIDTH, TILE_HEIGHT)];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
