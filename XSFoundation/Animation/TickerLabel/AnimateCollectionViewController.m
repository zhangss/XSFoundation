//
//  AnimateCollectionViewController.m
//  XSFoundation
//
//  Created by 张松松 on 15/11/14.
//  Copyright © 2015年 com.zhangss.foundation. All rights reserved.
//

#import "AnimateCollectionViewController.h"
#import "ADTickerLabel.h"

@interface AnimateCollectionViewController ()

@property (nonatomic, strong) ADTickerLabel *tickerLabel;
@property (nonatomic, strong) NSArray *numbersArray;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation AnimateCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.currentIndex = 0;
    self.numbersArray = @[@1, @29, @1098, @89, @18741984, @897];
    
    UIFont *font = [UIFont boldSystemFontOfSize:30];
    self.tickerLabel = [[ADTickerLabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, font.lineHeight)];
    self.tickerLabel.font = font;
    self.tickerLabel.characterWidth = 22;
    self.tickerLabel.changeTextAnimationDuration = 0.5;
    [self.view addSubview: self.tickerLabel];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tickerLabel.text = [NSString stringWithFormat:@"%@", self.numbersArray[self.currentIndex]];
    
    self.currentIndex++;
    if(self.currentIndex == [self.numbersArray count]) self.currentIndex = 0;
}

- (IBAction)buttonClicked:(id)sender{
    
    self.tickerLabel.text = [NSString stringWithFormat:@"%@", self.numbersArray[self.currentIndex]];
    
    self.currentIndex++;
    if(self.currentIndex == [self.numbersArray count]) self.currentIndex = 0;
}

@end
