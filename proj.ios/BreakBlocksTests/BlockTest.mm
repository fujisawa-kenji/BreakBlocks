//
//  BlockTest.m
//  BreakBlocks
//
//  Created by 藤澤　健治 on 2013/05/19.
//
//

#import "BlockTest.h"
#import "Block.h"
#import "PropertyChangedAssertionHelper.h"

@implementation BlockTest

- (void)testId
{
    Block b1;
    Block b2;
    Block b3;
    
    int count = b1.getId();
    STAssertEquals(count, b1.getId(), @"id expected %d, but was %d", count, b1.getId());
    STAssertEquals(count + 1, b2.getId(), @"id expected %d, but was %d", count + 1, b2.getId());
    STAssertEquals(count + 2, b3.getId(), @"id expected %d, but was %d", count + 2, b3.getId());
}

- (void)testDurability
{
    Block block;
    block.setDurability(1);
    STAssertEquals(1, block.getDurability(), @"durability expected %d, but was %d", 1, block.getDurability());
}

- (void)testDurabilityNotification
{
    PropertyChangedListenerMock listener;
    
    Block block;
    block.addListener(&listener);
    
    block.setDurability(0);
    STAssertPropertyNotChanged(&listener);
    
    block.setDurability(1);
    STAssertPropertyChangedInt(&listener, &block, @"durability", 0, 1);
}

@end
