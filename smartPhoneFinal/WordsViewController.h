//
//  WordsViewController.h
//  smartPhoneFinal
//
//  Created by fei Li on 12/15/16.
//  Copyright © 2016 fei Li. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ArticleStore+CoreDataClass.h"
#import "ArticleStore+CoreDataProperties.h"
#import "OnePassageViewController.h"
#import "VocabularyViewController.h"
#import "Notes+CoreDataProperties.h"

@class ArticleStore;
@class Inventory;
@class Notes;

@interface WordsViewController : UIViewController<UITextViewDelegate>
- (IBAction)HomeButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *wordItem;
- (IBAction)editNoteClicked:(id)sender;
- (IBAction)saveNoteClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UITextView *relatedArticles;


@property (strong, nonatomic) IBOutlet UITextView *NoteField;
- (IBAction)dismissWhenClickBlank:(id)sender;

- (IBAction)alradyKnewClicked:(id)sender;
- (IBAction)learnAgainClcked:(id)sender;


- (IBAction)viewTheFullArticle:(id)sender;



@property NSManagedObjectContext *myContext;
@property NSString *selectedWord;
@property  (weak,nonatomic)ArticleStore *selectedArticle;

@end
