//
//  Inventory+CoreDataProperties.h
//  smartPhoneFinal
//
//  Created by fei Li on 12/16/16.
//  Copyright © 2016 fei Li. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Inventory+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Inventory (CoreDataProperties)

+ (NSFetchRequest<Inventory *> *)fetchRequest;

@property (nonatomic) BOOL done;
@property (nullable, nonatomic, copy) NSDate *fisrtDate;
@property (nullable, nonatomic, copy) NSDate *lastDate;
@property (nonatomic) int16_t stage;
@property (nullable, nonatomic, copy) NSString *word;
@property (nullable, nonatomic, copy) NSString *note;
@property (nullable, nonatomic, retain) ArticleStore *relatedArticle;

@end

NS_ASSUME_NONNULL_END
