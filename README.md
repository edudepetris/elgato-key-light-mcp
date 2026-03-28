
## Test the tools via Standar IO and JSON-RPC

```json
{"jsonrpc": "2.0","id": 1,"method": "tools/call","params": {"name": "elgato_key_light_control_tool","arguments": { "on": 0, "brightness": 50, "temperature": 3000 }}}
```

```json
{"jsonrpc": "2.0","id": 1,"method": "tools/call","params": {"name": "elgato_key_light_status_tool","arguments": {}}}
```
