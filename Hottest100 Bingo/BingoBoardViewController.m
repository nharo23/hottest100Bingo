//
//  BingoBoardViewController.m
//  Hottest100 Bingo
//
//  Created by Robert Wagstaff on 4/01/13.
//  Copyright (c) 2013 Robert Wagstaff. All rights reserved.
//


#import "BingoBoardViewController.h"
#import "BingoBoardView.h"
#import "RulesViewController.h"
#import "SVModalWebViewController.h"

#define kKeyboardHeight 216


@interface BingoBoardViewController ()

@property (nonatomic,strong) BingoBoardView* mainBingoBoardView;

@property (nonatomic) int keyboardHeight;
@end

@implementation BingoBoardViewController

-(id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldStartedEditing:) name:@"TextFieldStarted" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rulesButtonTapped:) name:@"rulesButtonTapped" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(songListButtonTapped:) name:@"songListButtonTapped" object:nil];
    
    self.mainBingoBoardView = [[BingoBoardView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.mainBingoBoardView.backgroundColor = [UIColor whiteColor];
    self.mainBingoBoardView.alwaysBounceVertical = YES;
    
    
    [self.view addSubview:self.mainBingoBoardView];

}

-(void) keyboardWillHide:(NSNotification *) notification {
    [self.mainBingoBoardView setContentOffset:CGPointMake(0, 0) animated:YES];
}

-(void) textFieldStartedEditing:(NSNotification *) notification    {
    
    UITextField* currentTextField = [notification object];
    
    int currentTextFieldBottomYValue = currentTextField.frame.origin.y + currentTextField.frame.size.height;
    
    
    int hiddenYPos = SCREEN_HEIGHT - 20 - kKeyboardHeight - self.mainBingoBoardView.contentOffset.y;
    NSLog(@"%f",currentTextField.frame.origin.y);
    if(currentTextFieldBottomYValue > hiddenYPos) {
        
        int offsetToScrollTo = MIN(currentTextFieldBottomYValue- hiddenYPos, kKeyboardHeight);
        
        [self.mainBingoBoardView setContentOffset:CGPointMake(0, offsetToScrollTo) animated:YES];
    }
    
    //[self.mainBingoBoardView setContentOffset:CGPointMake(0, ) animated:YES];
//    
}

- (void) rulesButtonTapped:(NSNotification *) notification    {
    RulesViewController *rulesViewController = [[RulesViewController alloc] init];
    //rulesViewController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 20);
    [self presentViewController:rulesViewController animated:YES completion:nil];
}

- (void) songListButtonTapped:(NSNotification *) notification    {
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:@"http://www.abc.net.au/triplej/hottest100/12/"];
    [self presentViewController:webViewController animated:YES completion:nil];
}
@end
