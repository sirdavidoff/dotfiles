#!/bin/bash
cd /Users/David/Downloads
fn=$(ls -rt1 | tail -1)
query="/Users/David/Virtual Machines"
mv -f "$fn" "$query"
echo $fn moved to $(basename "$query")
