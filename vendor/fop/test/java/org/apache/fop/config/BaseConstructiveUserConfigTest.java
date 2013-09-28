/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* $Id: BaseConstructiveUserConfigTest.java 1198853 2011-11-07 18:18:29Z vhennebert $ */

package org.apache.fop.config;

import static org.junit.Assert.fail;

import org.junit.Test;

/**
 * Super class of several user config cases.
 */
public abstract class BaseConstructiveUserConfigTest extends BaseUserConfigTest {

    /**
     * Test using a standard FOP font
     * @throws Exception checkstyle wants a comment here, even a silly one
     */
    @Test
    public void testUserConfig() throws Exception {
        try {
            initConfig();
            convertFO();
        } catch (Exception e) {
            // this should *not* happen!
            e.printStackTrace();
            fail(e.getMessage());
        }
    }
}