//
//  BLBMyScene.m
//  Blob
//
//  Created by Ali Houshmand on 6/3/14.
//  Copyright (c) 2014 Ali Houshmand. All rights reserved.
//

#import "BLBMyScene.h"

@implementation BLBMyScene
{
    SKSpriteNode * hill1;
    SKSpriteNode * hill2;
    SKSpriteNode * hill3;
    
    SKSpriteNode * hill1c;
    SKSpriteNode * hill2c;
    SKSpriteNode * hill3c;
    
    NSArray * rollingTextures;
    
    SKSpriteNode * blob;
    
    
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [UIColor cyanColor];
        
        hill3 = [SKSpriteNode node];
        hill3.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"hill3"]];
        hill3.size = CGSizeMake(2048, 650);
        hill3.position = CGPointMake(1024, 325);
        hill3c = [hill3 copy];
        hill3c.position = CGPointMake(2048+1024, 325);
        [self addChild:hill3];
        [self addChild:hill3c];
        
        hill2 = [SKSpriteNode node];
        hill2.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"hill2"]];
        hill2.size = CGSizeMake(2048, 305);
        hill2.position = CGPointMake(1024, 152.5);
        hill2c = [hill2 copy];
        hill2c.position = CGPointMake(2048+1024, 152.5);
        [self addChild:hill2];
        [self addChild:hill2c];
        
        hill1 = [SKSpriteNode spriteNodeWithImageNamed:@"hill1"];
      //  hill1.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"hill1"]];
      //  hill1.size = CGSizeMake(2048, 265);
        hill1.position = CGPointMake(1024, 132.5);
        hill1c = [hill1 copy];
        hill1c.position = CGPointMake(1024+2048, 132.5);
        [self addChild:hill1];
        [self addChild:hill1c];
        
        SKSpriteNode * box = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(100,100)];
        [self addChild:box];
        
        blob = [SKSpriteNode spriteNodeWithImageNamed:@"blob_roll1"];
        blob.position = CGPointMake(self.size.width / 2.0, 100);
        
        rollingTextures = @[
                                      [SKTexture textureWithImageNamed:@"blob_roll1"],
                                      [SKTexture textureWithImageNamed:@"blob_roll2"],
                                      [SKTexture textureWithImageNamed:@"blob_roll3"],
                                      [SKTexture textureWithImageNamed:@"blob_roll4"],
                                      [SKTexture textureWithImageNamed:@"blob_roll6"],
                                      [SKTexture textureWithImageNamed:@"blob_roll7"],
                                      ];
        
        
        SKAction * rolling = [SKAction animateWithTextures:rollingTextures timePerFrame:.1];
      
        SKAction * infiniteRolling = [SKAction repeatActionForever:rolling];
        
        [blob runAction:infiniteRolling];
        
        blob.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:blob.size];
        blob.physicsBody.collisionBitMask = 1;
        blob.physicsBody.affectedByGravity = YES;
        [self addChild:blob];
        
        SKSpriteNode * floor = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(1024,50)];
        floor.position = CGPointMake(1024/2.0,25);
        floor.physicsBody = [ SKPhysicsBody bodyWithRectangleOfSize:floor.size];
        floor.physicsBody.collisionBitMask = 1;
        floor.physicsBody.affectedByGravity = NO;
        floor.physicsBody.dynamic = NO;

        [self addChild:floor];
        
    
     }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    
    for (UITouch *touch in touches) {
        
        CGPoint location = [touch locationInNode:self];
        
        float dx = (location.x < blob.position.x) ? -1.0 : 1.0;
        
        [blob.physicsBody applyImpulse:CGVectorMake(25 * dx, 100.0)];
        
        NSArray * reverseRollingTextures = [[rollingTextures reverseObjectEnumerator] allObjects];
        
        SKAction * rollingBackwards = [SKAction animateWithTextures:reverseRollingTextures timePerFrame:.1];

        SKAction * rollingTwice = [SKAction repeatAction:rollingBackwards count:2];
        
        if (dx<0) {
            
            [blob runAction:rollingTwice];
            
        }
        
        
    }
}

-(void)update:(CFTimeInterval)currentTime {

    hill1.position = CGPointMake(hill1.position.x-10, hill1.position.y);
    hill2.position = CGPointMake(hill2.position.x-8, hill2.position.y);
    hill3.position = CGPointMake(hill3.position.x-6, hill3.position.y);
    
    hill1c.position = CGPointMake(hill1c.position.x-10, hill1c.position.y);
    hill2c.position = CGPointMake(hill2c.position.x-8, hill2c.position.y);
    hill3c.position = CGPointMake(hill3c.position.x-6, hill3c.position.y);
    
    NSLog(@"%f", hill1.position.x);
    if(hill1.position.x < -1024) {
        
        hill1.position = CGPointMake(1024, hill1.position.y);
        hill1c.position = CGPointMake(1024+2048, hill1c.position.y);
        
    }

    if(hill2.position.x < -1024) {
        
        hill2.position = CGPointMake(1024, hill2.position.y);
        hill2c.position = CGPointMake(1024+2048, hill2c.position.y);
        
    }
    
    if(hill3.position.x < -1024) {
        
        hill3.position = CGPointMake(1024, hill3.position.y);
        hill3c.position = CGPointMake(1024+2048, hill3c.position.y);
        
    }
    
}

@end
