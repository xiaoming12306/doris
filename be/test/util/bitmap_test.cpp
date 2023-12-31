// Licensed to the Apache Software Foundation (ASF) under one
// or more contributor license agreements.  See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership.  The ASF licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

#include "util/bitmap.h"

#include <gtest/gtest-message.h>
#include <gtest/gtest-test-part.h>

#include "gtest/gtest_pred_impl.h"

namespace doris {

class BitMapTest : public testing::Test {
public:
    BitMapTest() {}
    virtual ~BitMapTest() {}
};

TEST_F(BitMapTest, normal) {
    // bitmap size
    EXPECT_EQ(0, BitmapSize(0));
    EXPECT_EQ(1, BitmapSize(1));
    EXPECT_EQ(1, BitmapSize(8));
    EXPECT_EQ(2, BitmapSize(9));

    // set, test, clear
    uint8_t bitmap[1024];
    memset(bitmap, 0, 1024);
    EXPECT_FALSE(BitmapTest(bitmap, 123));
    BitmapSet(bitmap, 123);
    EXPECT_TRUE(BitmapTest(bitmap, 123));
    BitmapClear(bitmap, 123);
    EXPECT_FALSE(BitmapTest(bitmap, 123));
    BitmapChange(bitmap, 112, true);
    EXPECT_TRUE(BitmapTest(bitmap, 112));
    BitmapChange(bitmap, 112, false);
    EXPECT_FALSE(BitmapTest(bitmap, 112));

    // change bits
    BitmapChangeBits(bitmap, 100, 200, true);
    for (int i = 0; i < 200; i++) {
        EXPECT_TRUE(BitmapTest(bitmap, 100 + i));
    }

    // Find fist
    bool found = false;
    size_t idx;
    found = BitmapFindFirstSet(bitmap, 0, 1024 * 8, &idx);
    EXPECT_TRUE(found);
    EXPECT_EQ(100, idx);

    found = BitmapFindFirstZero(bitmap, 200, 1024 * 8, &idx);
    EXPECT_TRUE(found);
    EXPECT_EQ(300, idx);

    found = BitmapFindFirstSet(bitmap, 300, 1024 * 8, &idx);
    EXPECT_FALSE(found);

    found = BitmapFindFirstZero(bitmap, 300, 1024 * 8, &idx);
    EXPECT_TRUE(found);
    EXPECT_EQ(300, idx);
}

TEST_F(BitMapTest, iterator) {
    uint8_t bitmap[1024];
    memset(bitmap, 0, 1024);

    for (int i = 100; i < 2000; ++i) {
        BitmapSet(bitmap, i);
    }

    for (int i = 2100; i < 3000; ++i) {
        BitmapSet(bitmap, i);
    }

    BitmapIterator iter(bitmap, 1024 * 8);
    EXPECT_FALSE(iter.done());

    bool value;
    // 0,100 --- false
    auto run = iter.Next(&value);
    EXPECT_FALSE(value);
    EXPECT_EQ(100, run);
    // 100,2000 -- true
    run = iter.Next(&value);
    EXPECT_TRUE(value);
    EXPECT_EQ(2000 - 100, run);
    // 2000,2100 -- false
    run = iter.Next(&value);
    EXPECT_FALSE(value);
    EXPECT_EQ(2100 - 2000, run);
    // 2100,3000 -- true
    run = iter.Next(&value);
    EXPECT_TRUE(value);
    EXPECT_EQ(3000 - 2100, run);
    // 3000,8*1024 -- false
    run = iter.Next(&value);
    EXPECT_FALSE(value);
    EXPECT_EQ(8 * 1024 - 3000, run);
    EXPECT_TRUE(iter.done());
    // seek to 8000
    iter.SeekTo(8000);
    run = iter.Next(&value);
    EXPECT_FALSE(value);
    EXPECT_EQ(8 * 1024 - 8000, run);
    EXPECT_TRUE(iter.done());

    // with max_run
    iter.SeekTo(200);
    run = iter.Next(&value, 500);
    EXPECT_TRUE(value);
    EXPECT_EQ(500, run);
    run = iter.Next(&value);
    EXPECT_TRUE(value);
    EXPECT_EQ(2000 - 500 - 200, run);
}

} // namespace doris
