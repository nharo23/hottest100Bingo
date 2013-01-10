//
//  RulesViewController.m
//  Hottest100 Bingo
//
//  Created by Robert Wagstaff on 11/01/13.
//  Copyright (c) 2013 Robert Wagstaff. All rights reserved.
//

#import "RulesViewController.h"

@interface RulesViewController ()

@end

@implementation RulesViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        recognizer.delegate = self;
        [self.view addGestureRecognizer:recognizer];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITextView* headingTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 10, 320, 50)];
    
    [headingTextView setFont:[UIFont systemFontOfSize:30.0]];
    headingTextView.textColor = [UIColor blueColor];
    headingTextView.backgroundColor = [UIColor clearColor];
    headingTextView.text = @"Rules";
    headingTextView.textAlignment = NSTextAlignmentCenter;
    headingTextView.scrollEnabled = NO;
    headingTextView.userInteractionEnabled = NO;
    
    UITextView* rulesTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 80, 320, 410)];
    
    [rulesTextView setFont:[UIFont systemFontOfSize:16]];
    rulesTextView.textColor = [UIColor blueColor];
    rulesTextView.backgroundColor = [UIColor clearColor];
    rulesTextView.text = @"1) Fill out the bingo board with an artist and song name for each bingo tile\n2) As the songs are played on the Triple J Hottest 100 Countdown, mark them off your board\n3) The first player to have four in a row and call 'BINGO' wins the game\n\n\nThere is also a competition for picking the number 1 song of the countdown.\nIf more than one player has the same number one song then the number two and three song selections will be used to break the tie";
    rulesTextView.textAlignment = NSTextAlignmentCenter;
    rulesTextView.scrollEnabled = NO;
    rulesTextView.userInteractionEnabled = NO;
    
    [self.view addSubview:headingTextView];
    [self.view addSubview:rulesTextView];
	// Do any additional setup after loading the view.
}


- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
