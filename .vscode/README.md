# VS Code MCP

Configured servers in `.vscode/mcp.json`:

- `filesystem`: current local repository access
- `github`: GitHub repositories/issues/PR context, read-only
- `context7`: current library/framework documentation

Authentication:
- GitHub remote MCP uses GitHub/VS Code OAuth.
- Context7 remote MCP uses OAuth.
- Filesystem MCP requires Node.js/npx.

Do not put API keys or personal access tokens in this file.

The GitHub server is intentionally read-only during bootstrap. Enable write operations later only if required.

### Windows note
`mcp.json` invokes `npx` directly, which works on macOS/Linux and on Windows when
`npx` is on PATH. If VS Code fails to resolve `npx` on Windows, change the
`filesystem` server's `command`/`args` to:

```json
"command": "cmd",
"args": ["/c", "npx", "-y", "@modelcontextprotocol/server-filesystem", "${workspaceFolder}"]
```
