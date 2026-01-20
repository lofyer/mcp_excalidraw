# MCP Excalidraw ABM 镜像

合并 Canvas + MCP 服务的 Docker 镜像，一个容器搞定全部。

## 构建

```bash
./build-docker-image.sh
```

## 运行

```bash
docker run -i -p 3000:3000 mcp-excalidraw-abm
```

- Canvas 服务：http://localhost:3000
- MCP 服务：stdin/stdout

## 环境变量

| 变量 | 默认值 | 说明 |
|------|--------|------|
| `NODE_ENV` | `production` | 运行环境 |
| `PORT` | `3000` | Canvas 服务端口 |
| `HOST` | `0.0.0.0` | 监听地址 |
| `EXPRESS_SERVER_URL` | `http://localhost:3000` | MCP 连接 Canvas 的地址 |
| `ENABLE_CANVAS_SYNC` | `true` | 启用画布同步 |
| `DEBUG` | `false` | 调试模式 |

## MCP Server 配置

### Claude Desktop

配置文件位置：
- **macOS**: `~/Library/Application Support/Claude/claude_desktop_config.json`
- **Linux**: `~/.config/claude/claude_desktop_config.json`
- **Windows**: `%APPDATA%\Claude\claude_desktop_config.json`

```json
{
  "mcpServers": {
    "mcp_excalidraw": {
      "command": "docker",
      "args": ["run", "-i", "--rm", "-p", "3000:3000", "mcp-excalidraw-abm"]
    }
  }
}
```

### Claude Code

在项目根目录创建 `.mcp.json`：

```json
{
  "mcpServers": {
    "mcp_excalidraw": {
      "command": "docker",
      "args": ["run", "-i", "--rm", "-p", "3000:3000", "mcp-excalidraw-abm"]
    }
  }
}
```

或使用 CLI：

```bash
claude mcp add --scope project --transport stdio mcp_excalidraw \
  -- docker run -i --rm -p 3000:3000 mcp-excalidraw-abm
```

### Cursor

编辑 `~/.cursor/mcp.json`：

```json
{
  "mcpServers": {
    "mcp_excalidraw": {
      "command": "docker",
      "args": ["run", "-i", "--rm", "-p", "3000:3000", "mcp-excalidraw-abm"]
    }
  }
}
```

## 端口说明

| 服务 | 端口 | 说明 |
|------|------|------|
| Canvas | 3000 | Web UI + REST API + WebSocket |
| MCP | stdin/stdout | Model Context Protocol |

## 与原版的区别

| 特性 | 原版 (分离部署) | ABM (合并部署) |
|------|----------------|----------------|
| 容器数量 | 2 个 | 1 个 |
| 网络配置 | 需要 `--network host` | 不需要 |
| Node 版本 | 18 | 22 |
| NPM 源 | 官方 | 淘宝镜像 |
