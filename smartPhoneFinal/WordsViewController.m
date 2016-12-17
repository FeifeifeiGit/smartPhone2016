//
//  WordsViewController.m
//  smartPhoneFinal
//
//  Created by fei Li on 12/15/16.
//  Copyright © 2016 fei Li. All rights reserved.
//

#import "WordsViewController.h"


@interface WordsViewController ()
-(void)loadInfo;
-(void)loadTodayPlan;
-(void)doAnimation;
@property (strong,nonatomic) NSDate *testDate;
@property Boolean isnewWord;
@property NSArray *intervals ;
@property NSMutableArray *todayWords;
@property Inventory *currentWord;
@end

@implementation WordsViewController

- (void)viewDidLoad {
    _intervals = [NSArray  arrayWithObjects:@"1", @"3",@"7",@"11",@"17",nil];
    [super viewDidLoad];
    _NoteField.delegate=self;
    _NoteField.editable=NO;
    _NoteField.textColor=[UIColor blackColor];
    _relatedArticles.textColor=[UIColor blackColor];
    
    //if the self is presented by passage, then it is to add the word, loadinfo to textView
    if([self.presentingViewController isKindOfClass: [OnePassageViewController class]]){
        NSLog(@"words from OnePassageViewController");
    [self loadInfo];
        
    }else if ([self.presentingViewController isKindOfClass: [VocabularyViewController class]]){
   //if the self is from vocabulary , then it is to  loadTodayPlan, and populate the first words to textview
        [self loadTodayPlan];
        _currentWord = [_todayWords firstObject];
         NSLog(@"words from VocabularyViewController");
    }
}
-(void)viewWillAppear:(BOOL)animated{
    _NoteField.editable=NO;
    if([_todayWords count]==0){
        NSLog(@"you have completed all your words!!!");
        return;
    }
    _currentWord = [_todayWords firstObject];
    _wordItem.text=_currentWord.word;
    _NoteField.text=_currentWord.notesList.noteContent;
    _relatedArticles.text= _currentWord.relatedArticle.summary;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadInfo{
    _wordItem.text = _selectedWord;
    _relatedArticles.text = _selectedArticle.summary;
    //find the word to see if it is a new one
    [self checkIfNew];
 
}

-(Inventory*)checkIfNew{
   NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Inventory"];
   NSPredicate *pre = [NSPredicate predicateWithFormat:@"word = %@",
                    _selectedWord];
   request.predicate = pre;
   NSError *error = nil;
   NSArray *emps = [_myContext executeFetchRequest:request error:&error];
    if (error) {
       NSLog(@"error");
   }
    if([emps count]!=0){
        _isnewWord= NO;
        Inventory *test = [emps firstObject];
        _currentWord = test;
       _NoteField.text= test.notesList.noteContent;
    NSLog(@"The words already in your inventory");
        return [emps firstObject];

    }else{
        _isnewWord = YES;
         NSLog(@"The words is new");
        return nil;
   }
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
    if(_isnewWord==YES){
        Inventory *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Inventory" inManagedObjectContext:_myContext];
        newItem.word = _selectedWord;
        newItem.stage = 0;
        NSDate *currDate = [NSDate date];
        newItem.fisrtDate =currDate;
        newItem.lastDate = currDate;
        newItem.relatedArticle = _selectedArticle;
        NSError *error = nil;
        if([_myContext hasChanges]){
            [_myContext save:&error];
        }
        if (error) {
            NSLog(@"%@",error);
        }
        [[self.view viewWithTag:1] setHidden:YES];
        [[self.view viewWithTag:2] setHidden:YES];
    //add a alert to inform new word added
    }else{
        //not new words
        Inventory *tmp =[self checkIfNew];
        tmp.notesList.noteContent = _NoteField.text;
         NSError *error;
        if([_myContext hasChanges]){
           
            [_myContext save:&error];
        }
        if (error) {
            NSLog(@"%@",error);
        }
    }
}
-(void)loadTodayPlan{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Inventory"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"done = %@",
                        NO];
    request.predicate = pre;
    NSError *error = nil;
    NSArray *allwords = [_myContext executeFetchRequest:request error:&error];
    NSDate *today = [NSDate date];
    if (error) {
        NSLog(@"error");
    }
    for(Inventory *w in allwords){
        if(w.done==YES){
            NSLog(@"This word is done, skip this one");
            continue;
        }
      NSTimeInterval duration = fabs([w.lastDate timeIntervalSinceNow]);
      NSInteger days = ((NSInteger) duration) / (60 * 60 * 24);
       //test by changing days here
        switch (w.stage) {
            case 0:
                if((days >= 1)){
                    [_todayWords addObject:w];
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
    [ self  doAnimation];
}

- (IBAction)learnAgainClcked:(id)sender {
    //stage -1
    
    //update the lastDate
    
    //save to db
}

-(void)doAnimation{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [self.view setOpaque:YES];
    [UIView commitAnimations];
}

- (IBAction)viewTheFullArticle:(id)sender {
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
