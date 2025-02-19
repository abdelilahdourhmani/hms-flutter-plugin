/*
    Copyright 2021. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License")
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        https://www.apache.org/licenses/LICENSE-2.0
        
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

package com.huawei.hms.flutter.modeling3d.utils;

import io.flutter.plugin.common.MethodCall;

public final class ValueGetter {

    private ValueGetter() {
    }

    public static String getString(final String key, final MethodCall call) {
        final Object value = call.argument(key);
        if (value instanceof String) {
            return (String) value;
        } else {
            throw new IllegalArgumentException("String argument null or empty");
        }
    }

    public static int getInteger(final String key, final MethodCall call) {
        final Object value = call.argument(key);
        if (value instanceof Integer) {
            return (int) value;
        } else {
            throw new IllegalArgumentException("Integer argument null or empty");
        }
    }

}
