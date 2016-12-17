//
//  Completion+CoreDataProperties.m
//  smartPhoneFinal
//
//  Created by fei Li on 12/17/16.
//  Copyright © 2016 fei Li. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Completion+CoreDataProperties.h"

@implementation Completion (CoreDataProperties)

+ (NSFetchRequest<Completion *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Completion"];
}

@dynamic date;
@dynamic number;

@end
