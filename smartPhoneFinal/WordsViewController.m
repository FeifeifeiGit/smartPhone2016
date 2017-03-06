//
//  WordsViewController.m
//  smartPhoneFinal
//
//  Created by fei Li on 12/15/16.
//  Copyright © 2016 fei Li. All rights reserved.
//

#import "WordsViewController.h"
#import "Completion+CoreDataProperties.h"

@interface WordsViewController ()
-(void)loadTodayPlan;
-(void)doAnimation;
-(void)saveCompletion:(NSDate*) dateCompltion;
@property (strong,nonatomic) NSDate *testDate;
@property Boolean isnewWord;
@property NSArray *intervals ;
@property NSMutableArray *todayWords;
@property Inventory *currentWord;
@end

@implementation WordsViewController

- (void)viewDidLoad {
    NSLog(@"viewDidLoad is called");
    _intervals = [NSArray  arrayWithObjects:@"1", @"3",@"7",@"11",@"17",nil];
    [super viewDidLoad];
    //_NoteField.delegate=self;
    _NoteField.editable=NO;
    _NoteField.textColor=[UIColor blackColor];
    _todayWords = [[NSMutableArray alloc]init];
    _relatedArticles.textColor=[UIColor blackColor];
     [self loadTodayPlan];
    }

-(void)viewWillAppear:(BOOL)animated{
    _NoteField.editable=NO;
    _currentWord = [_todayWords firstObject];
    if(_currentWord==NULL){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"INFORMATION"
                                                                       message:@"You complete Today's Plan"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    NSLog(@"here is wordsVC viewWillApear: currentWord is %@", _currentWord.word);
        _wordItem.text=_currentWord.word;
        _NoteField.text=_currentWord.note;
        _relatedArticles.text= _currentWord.relatedArticle.summary;
}

-(void)viewWillDisappear:(BOOL)animated{

    //save today's completion
    NSDate *date= [NSDate date];
    [self saveCompletion: date];
    NSLog(@"willdisapear is called");
}
-(void)saveCompletion:(NSDate*) dateCompltion{
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Completion"];
    NSPredicate  *predict = [NSPredicate predicateWithFormat:@"date = %@",
                                    [NSDate date]];
    request.predicate = predict;
    NSError *error;
    NSArray *todaysComplettionItems = [_myContext executeFetchRequest:request error:&error];
    if([todaysComplettionItems count]>0){
        Completion *updateToday = [todaysComplettionItems firstObject];
        updateToday.number=_Completed;
        NSError *error = nil;
        if([_myContext hasChanges]){
            [_myContext save:&error];
        }
        if (error) {
            NSLog(@"%@",error);
        }
    }else{
        Completion  *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Completion" inManagedObjectContext:_myContext];
        newItem.date = dateCompltion;
        newItem.number = _Completed;
        NSError *error = nil;
        if([_myContext hasChanges]){
            [_myContext save:&error];
        }
        if (error) {
            NSLog(@"%@",error);
        }
        NSLog(@"%hd is added to completed, its date is : %@",newItem.number,newItem.date);
    }
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

- (IBAction)HomeButtonClicked:(id)sender {
    [ self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
}
- (IBAction)editNoteClicked:(id)sender {
    _NoteField.editable=YES;
    [_NoteField becomeFirstResponder];
    
}

- (IBAction)saveNoteClicked:(id)sender {
    _NoteField.editable=NO;
    [_NoteField resignFirstResponder];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Inventory"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"word = %@",
                        _currentWord.word];
    request.predicate = pre;
    NSError *error;
    NSArray *allwords = [_myContext executeFetchRequest:request error:&error];
    Inventory *wordToSave = [allwords firstObject];
    wordToSave.note = _NoteField.text;
        if([_myContext hasChanges]){
            [_myContext save:&error];
            _noteSavedLabel.text = @"Note is updated!!!";
            [_noteSavedLabel setTextColor:[UIColor redColor]];
        }
        if (error) {
            NSLog(@"%@",error);
        }
}


-(void)loadTodayPlan{
    NSLog(@"loadTodayPlan is called");
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Inventory"];
   NSPredicate *pre = [NSPredicate predicateWithFormat:@"done == %d",
                        0];
    request.predicate = pre;
    request.fetchLimit = _fetchLimit;
    
    NSError *error = nil;
    NSArray *allwords = [_myContext executeFetchRequest:request error:&error];
    NSLog(@"size of all fecthed words: %lu", (unsigned long)[allwords count]);
 //   NSDate *today = [NSDate date];
    if (error) {
        NSLog(@"error");
    }
    for(Inventory *w in allwords){
      //  NSLog(@"inventory w's done= %d", w.done);
          NSLog(@"inventory w's stage= %d", w.stage);
      NSTimeInterval duration = fabs([w.lastDate timeIntervalSinceNow]);
  //    NSInteger days = ((NSInteger) duration) / (60 * 60 * 24);
       //test by changing days here, so every word will be loaded to today's plan
        NSInteger days = 20;
        switch (w.stage) {
            case 0:
                if((days >= 1)){
                    [_todayWords addObject:w];
                    NSLog(@"todayWords count: %lu", (unsigned long)[_todayWords count]);
                }
                break;
            case 1:
                if((days >= 3)){
                    [_todayWords addObject:w];
                }
                break;
            case 2:
                if((days >= 5)){
                    [_todayWords addObject:w];
                }
                break;
            case 3:
                if((days >= 11)){
                    [_todayWords addObject:w];
                }
                break;
            case 4:
                if((days >= 19)){
                    [_todayWords addObject:w];
                }
                break;
            case 5:
                if((days >= 20)){
                    [_todayWords addObject:w];
                }
                break;
            default:
                break;
        }
    }
}


- (IBAction)dismissWhenClickBlank:(id)sender {
    [_NoteField resignFirstResponder];
    
}

- (IBAction)alradyKnewClicked:(id)sender {
    //stage +1
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Inventory"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"word = %@",
                        _currentWord.word];
    request.predicate = pre;
    NSError *error = nil;
    NSArray *emps = [_myContext executeFetchRequest:request error:&error];
    Inventory *wToUpdate = [emps firstObject];
    if(_currentWord.stage==5){
        _currentWord.done=YES;
    }else{
    wToUpdate.stage = _currentWord.stage+1;
    }
    //update the lastDate
    wToUpdate.lastDate = [NSDate date];
    //save to db
    if([_myContext hasChanges]){
        [_myContext save:&error];
    }
    if (error) {
        NSLog(@"%@",error);
    }
    //remove the word from today's word
    [_todayWords removeObject:_currentWord];
    [self viewWillAppear:YES];
     _Completed++;
    
    [self saveCompletion: [NSDate date]];
    [ self  doAnimation];
}

- (IBAction)learnAgainClcked:(id)sender {
    //stage -1
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Inventory"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"word = %@",
                        _currentWord.word];
    request.predicate = pre;
    NSError *error = nil;
    NSArray *emps = [_myContext executeFetchRequest:request error:&error];
    Inventory *wToUpdate = [emps firstObject];
    if(_currentWord.stage==0){
        _currentWord.stage=0;
    }else{
        wToUpdate.stage = _currentWord.stage - 1;
    }
    //update the lastDate
    wToUpdate.lastDate = [NSDate date];
    //save to db
    if([_myContext hasChanges]){
        [_myContext save:&error];
    }
    if (error) {
        NSLog(@"%@",error);
    }
    //remove the word from today's word
    [_todayWords removeObject:_currentWord];
    _Completed++;
    [self viewWillAppear:YES];
    [self saveCompletion: [NSDate date]];
    [ self  doAnimation];
}

-(void)doAnimation{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [self.view setOpaque:YES];
    [UIView commitAnimations];
}

- (IBAction)viewTheFullArticle:(id)sender {
    ArticleStore *relatedArticle = _currentWord.relatedArticle;
    OnePassageViewController *backToArticle = [[OnePassageViewController alloc]init];
    backToArticle.selctedPassage = relatedArticle;
    [self presentViewController:backToArticle animated:NO completion:nil];
    
}
/*
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSRange resultRange = [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet] options:NSBackwardsSearch];
    if ([text length] == 1 && resultRange.location != NSNotFound) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}
 */

@end
