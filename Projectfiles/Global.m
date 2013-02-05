//
//  Global.m
//  flyvsplants1
//
//  Created by Rafael Rodríguez Arguedas on 02/02/13.
//
//

#import "Global.h"

@implementation Global
@synthesize level;
@synthesize levelunlocked;
@synthesize statu;

+(id)sharedManager
{
    static Global *sharedMyManager = nil;
    @synchronized(self)
    {
        if (sharedMyManager == nil)
        {
            sharedMyManager = [[self alloc] init];
        }
    }
    return sharedMyManager;
}

-(id)init
{
    if (self = [super init])
    {
        level=1;
        levelunlocked=1;
        statu=1;
    }
    return self;
}

-(void)dealloc
{
}

@end