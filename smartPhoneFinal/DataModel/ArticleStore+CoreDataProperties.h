//
//  ArticleStore+CoreDataProperties.h
//  smartPhoneFinal
//
//  Created by fei Li on 12/16/16.
//  Copyright © 2016 fei Li. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "ArticleStore+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ArticleStore (CoreDataProperties)

+ (NSFetchRequest<ArticleStore *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *articleName;
@property (nullable, nonatomic, copy) NSString *category;
@property (nullable, nonatomic, copy) NSString *summary;

@end

NS_ASSUME_NONNULL_END
