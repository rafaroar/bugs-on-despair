//
//  Bazooka.h
//  flyvsplants1
//
//  Created by Andrea Rodríguez Arguedas on 31/01/13.
//
//

#import "kobold2d.h"

@interface Bazooka : CCSprite
{
    CCTexture2D* bazookatex;
    CCTexture2D* explosion;
}
-(id) initWithBombImage;
-(void)explode: (NSMutableArray*)supplants;
@end
