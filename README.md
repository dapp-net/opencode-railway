# OpenCode Web on Railway

Deploy OpenCode Web interface on Railway.cloud with persistent storage.

## Features

- OpenCode Web UI accessible via browser
- Persistent workspace using Railway Volume (5GB)
- OpenCode Go (Zen) integration
- Basic authentication protection
- Automatic HTTPS via Railway

## Prerequisites

- Railway CLI installed and authenticated
- OpenCode account with API key from opencode.ai

## Deployment

### 1. Clone and setup

```bash
git clone <your-repo>
cd opencode-railway
```

### 2. Deploy to Railway

```bash
railway login
railway init
railway up
```

### 3. Configure environment variables

In Railway Dashboard, set these variables:

```env
OPENCODE_SERVER_PASSWORD=your_secure_password
OPENCODE_SERVER_USERNAME=admin
OPENCODE_API_KEY=your_opencode_zen_api_key
```

Get your API key at: https://opencode.ai/auth

### 4. Access your OpenCode Web

After deployment, Railway will provide a URL like:
`https://opencode-web-production.up.railway.app`

Login with your configured username/password.

## Volume

The workspace is persisted at `/workspace` with 5GB storage.
This includes:
- Git repositories
- OpenCode configuration
- Session history
- Project files

## Local Development

```bash
# Build and run locally
docker build -t opencode-railway .
docker run -p 3000:3000 -v $(pwd)/workspace:/workspace \
  -e OPENCODE_SERVER_PASSWORD=dev \
  -e PORT=3000 \
  opencode-railway
```

## Troubleshooting

**Container won't start:**
- Check that `OPENCODE_SERVER_PASSWORD` is set
- Verify `PORT` environment variable is available

**Can't access web UI:**
- Railway service must be running
- Check logs: `railway logs`

**Volume issues:**
- Ensure volume is attached in Railway dashboard
- Check permissions: `/workspace` must be writable

## License

MIT
