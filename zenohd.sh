#!/bin/bash
#
# Copyright 2026 Open Source Robotics Foundation, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Capture the arguments passed by Bazel's 'args' attribute
TOOL_PATH="$1"
CONFIG_PATH="$2"
shift 2

# Execute the Rust binary with the resolved paths and any remaining args
exec "$TOOL_PATH" --config "$CONFIG_PATH" "$@"