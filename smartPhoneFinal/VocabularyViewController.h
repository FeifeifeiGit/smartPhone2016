//
//  VocabularyViewController.h
//  smartPhoneFinal
//
//  Created by fei Li on 12/14/16.
//  Copyright © 2016 fei Li. All rights reserved.
//where

#import <UIKit/UIKit.h>


@interface VocabularyViewController : UIViewController

@property NSManagedObjectContext *myContext;
@property (strong, nonatomic) IBOutlet UIView *statusView;
@property (strong, nonatomic) IBOutlet UILabel *LearnedDays;
@property (strong, nonatomic) IBOutlet UILabel *learnedWords;
@property (strong, nonatomic) IBOutlet UILabel *totalWords;


@property (strong, nonatomic) IBOutlet UIView *todayView;
@property (strong, nonatomic) IBOutlet UILabel *todayWords;

@property (strong, nonatomic) IBOutlet UILabel *wordsCompletedToday;


-(IBAction)startButtonClicked:(id)sender;

@property (strong, nonatomic)
IBOutlet UIButton *startButton;






@end
