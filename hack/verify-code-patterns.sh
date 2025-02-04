#!/usr/bin/env bash

# Copyright 2019 The Kubernetes Authors.
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

set -euo pipefail

out="$( find . -name '*_test.go' -not -path './vendor/*' -print0 | xargs -0 grep -En 'ioutil\.TempDir' || [[ $? == 123 ]] )"
if [[ -n "$out" ]]; then
  echo >&2 "You used ioutil.TempDir in tests, use 'testutil.NewTempDir()' instead:"
  echo >&2 "$out"
  exit 1
fi
