//
//  Notes+CoreDataProperties.m
//  smartPhoneFinal
//
//  Created by fei Li on 12/16/16.
//  Copyright © 2016 fei Li. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Notes+CoreDataProperties.h"

@implementation Notes (CoreDataProperties)

+ (NSFetchRequest<Notes *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Notes"];
}

@dynamic noteContent;

@end
