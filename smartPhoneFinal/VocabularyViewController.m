//
//  VocabularyViewController.m
//  smartPhoneFinal
//
//  Created by fei Li on 12/14/16.
//  Copyright © 2016 fei Li. All rights reserved.
//

#import "VocabularyViewController.h"
#import <CoreData/CoreData.h>
#import "WordsViewController.h"
@interface VocabularyViewController ()
-(void)setTodayWord;
-(void)updateTotalDaysAndWords;
@end

@implementation VocabularyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self setTodayWord];
    NSLog(@"Vocab vc viewDidLoad.  context is :%@",self.myContext);
}
-(void)viewWillAppear:(BOOL)animated{
     [self setTodayWord];
     [self updateCompletedNum];
     [self updateTotalDaysAndWords];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)startButtonClicked:(id)sender{
 WordsViewController  *newWords = [[WordsViewController alloc]init];
    newWords.myContext = _myContext;
    [self presentViewController:newWords animated:YES completion:nil];
}
-(void)updateCompletedNum{
    WordsViewController *t = (WordsViewController*)self.presentedViewController;
    _wordsCompletedToday.text =[ NSString stringWithFormat:@"%ld",(long)t.Completed];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setTodayWord{
    NSInteger num = [[NSUserDefaults standardUserDefaults] integerForKey:@"DailyGoal"];
    _todayWords.text=[NSString  stringWithFormat:@"%ld", (long)num];
}

-(void)updateTotalDaysAndWords{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Inventory"];
    NSError *error = nil;
    NSArray *allwords = [_myContext executeFetchRequest:request error:&error];
    NSInteger *totalWords =(long) [allwords count];
    _totalWords.text = [NSString stringWithFormat:@"%ld", (long)totalWords ];
    NSLog(@"totalWords is %d", totalWords);
  
   //days
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"fisrtDate"
                                                                   ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    NSArray *sortedResults = [_myContext executeFetchRequest:request error:&error];
    Inventory *firstlearnt = [sortedResults objectAtIndex:0];
    NSDate *firstDay = firstlearnt.fisrtDate;
   
    NSDate *date1 = [NSDate dateWithTimeIntervalSinceNow: 4492800];
   // NSDate *date2 = [NSDate dateWithString:@"2010-02-31 00:00:00 +0000"];
   // NSTimeInterval duration = [date2 timeIntervalSinceDate:date1];
  // NSTimeInterval duration = fabs([firstDay timeIntervalSinceNow]);
    NSTimeInterval duration = fabs([date1 timeIntervalSinceNow]);
      NSInteger days = ((NSInteger) duration) / (60 * 60 * 24);
    _LearnedDays.text =[NSString stringWithFormat:@"%ld", (long)days ];
    
    //done words
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"done == %d",1];
    request.predicate = pre;
    NSArray *doneWords = [_myContext executeFetchRequest:request error:&error];
    _learnedWords.text =[NSString stringWithFormat:@"%ld", (long)[doneWords count]];

}

@end
