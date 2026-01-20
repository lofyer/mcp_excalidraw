#!/bin/bash
set -e
cd "$(dirname "$0")"

echo "=== 构建合并镜像 (Canvas + MCP) ==="
docker build --progress=plain -f Dockerfile.abm -t mcp-excalidraw-abm:latest . 2>&1 | tee build.log

echo ""
echo "=== 构建完成 ==="
docker images | grep mcp-excalidraw-abm

echo ""
echo "=== 使用方法 ==="
echo "docker run -i -p 3000:3000 mcp-excalidraw-abm"
