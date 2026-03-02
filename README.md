# Claude Advanced Plugins

A comprehensive collection of **12 advanced plugins** for [Claude Code](https://docs.anthropic.com/en/docs/claude-code) that supercharge your development, security, and productivity workflows.

Each plugin installs as a custom slash command in Claude Code, giving you instant access to specialized expertise.

## Quick Install

```bash
git clone https://github.com/CyberSecurityUP/ClaudeAdvancedPlugins.git
cd ClaudeAdvancedPlugins
chmod +x install.sh
./install.sh
```

That's it. All plugins are now available as `/command-name` in Claude Code.

## Plugins

### Development

| Plugin | Commands | Description |
|--------|----------|-------------|
| **Backend Architect** | `/backend-architect`, `/backend-api-design`, `/backend-db-optimize` | System architecture, API design, database optimization, scalability patterns |
| **Frontend Forge** | `/frontend-forge`, `/frontend-component` | Component architecture, performance, accessibility, design systems |

### Security & Offensive

| Plugin | Commands | Description |
|--------|----------|-------------|
| **Red Team Ops** | `/red-team-ops`, `/red-team-payload` | Adversary simulation, attack chain design, MITRE ATT&CK mapping, C2 ops |
| **Pentest Toolkit** | `/pentest-toolkit`, `/pentest-web` | Full PTES methodology, web app testing, OWASP Top 10, vulnerability assessment |
| **Exploit Dev** | `/exploit-dev`, `/exploit-ctf` | Binary exploitation, ROP chains, heap techniques, CTF solving |
| **API Security** | `/api-security` | OWASP API Security Top 10, GraphQL/gRPC testing, authentication bypass |
| **Secure Code Review** | `/secure-code-review` | SAST-style code review, vulnerability detection, CWE mapping |
| **Threat Modeler** | `/threat-modeler` | STRIDE, DREAD, PASTA frameworks, attack trees, risk analysis |

### Productivity & AI

| Plugin | Commands | Description |
|--------|----------|-------------|
| **Memory Vault** | `/memory-vault` | Persistent knowledge management across Claude Code sessions |
| **Context Manager** | `/context-manager` | Context window optimization, smart file loading, context preservation |
| **Hallucination Guard** | `/hallucination-guard` | Accuracy verification, confidence signaling, source validation |

### Systems

| Plugin | Commands | Description |
|--------|----------|-------------|
| **OS Internals** | `/os-internals`, `/os-debug` | Kernel internals, process/memory management, system debugging |

## Usage

After installation, use any command in Claude Code by typing the slash command followed by your request:

```
/backend-architect Design a microservices architecture for an e-commerce platform

/pentest-web Test the login form for SQL injection and authentication bypass

/red-team-ops Plan a phishing simulation for the Q4 security assessment

/exploit-ctf Solve this PWN challenge: buffer overflow with NX enabled, no PIE

/hallucination-guard Verify that the React useEffect cleanup runs on unmount

/os-internals Explain how Linux handles page faults in detail

/threat-modeler Model threats for a payment processing API

/secure-code-review Review this Express.js middleware for security issues

/frontend-forge Build an accessible data table component with sorting and filtering

/context-manager Optimize context loading for working on the auth module

/memory-vault save conventions This project uses kebab-case for file names
```

## Selective Installation

Install only specific plugins:

```bash
# Install only security plugins
./install.sh -p red-team-ops -p pentest-toolkit -p exploit-dev

# Install only development plugins
./install.sh -p backend-architect -p frontend-forge

# List all available plugins
./install.sh --list

# Force reinstall (overwrite existing)
./install.sh --force
```

## Uninstall

```bash
# Uninstall all plugins
./uninstall.sh

# Or use the installer
./install.sh --uninstall
```

## Plugin Details

### Backend Architect
Expert system architecture and API design. Covers distributed systems, database optimization, caching strategies, resilience patterns, and observability. Produces architecture diagrams, API specs, data models, and implementation roadmaps.

### Frontend Forge
Modern frontend engineering with focus on component architecture, Core Web Vitals, accessibility (WCAG 2.1 AA), and design systems. Generates production-ready TypeScript components with tests.

### Red Team Ops
Adversary simulation and offensive operations for authorized engagements. Maps to MITRE ATT&CK framework. Covers initial access, post-exploitation, persistence, lateral movement, and evasion. Always includes detection opportunities for purple teaming.

### Pentest Toolkit
Full penetration testing methodology (PTES). From reconnaissance through reporting. Includes web application testing with complete OWASP Top 10 coverage, CVSS scoring, and remediation roadmaps.

### Exploit Dev
Binary exploitation, web exploitation, and reverse engineering for authorized research and CTF competitions. Covers ROP, heap exploitation, format strings, deserialization, and modern protection bypass techniques.

### API Security
Comprehensive API security testing against OWASP API Security Top 10 (2023). Covers BOLA, broken authentication, SSRF, and more. Includes GraphQL, gRPC, and WebSocket specific attacks.

### Secure Code Review
Systematic security code review covering injection, authentication, authorization, cryptography, and data protection. Maps findings to CWE and provides remediation with code examples.

### Threat Modeler
Structured threat modeling using STRIDE, DREAD, PASTA, and Attack Trees. Produces data flow diagrams, threat catalogs, risk matrices, and mitigation roadmaps with MITRE ATT&CK mapping.

### Memory Vault
Intelligent persistent memory management. Captures architecture decisions, debugging insights, project conventions, and user preferences. Organizes knowledge semantically for efficient recall across sessions.

### Context Manager
Optimizes Claude Code's context window usage. Prioritizes file loading, compresses context, creates checkpoints, and recovers from context compression. Reduces wasted tokens and improves response quality.

### Hallucination Guard
Active hallucination prevention system. Verifies claims against actual source code and documentation, provides confidence levels, catches common hallucination patterns (API, path, version, behavioral), and implements self-correction protocols.

### OS Internals
Deep systems knowledge covering Linux, Windows, and macOS internals. Process management, memory management, file systems, networking stack, kernel internals, and system-level debugging with practical examples.

## How It Works

Claude Code supports [custom slash commands](https://docs.anthropic.com/en/docs/claude-code) stored as Markdown files in `~/.claude/commands/`. Each plugin is a carefully crafted system prompt that activates specialized expertise when invoked.

The install script simply copies the command `.md` files to your Claude commands directory. No dependencies, no runtime, no configuration.

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI installed
- Bash shell (macOS, Linux, WSL)

## Security Disclaimer

The security-focused plugins (Red Team Ops, Pentest Toolkit, Exploit Dev, API Security) are designed for **authorized security testing only**. This includes:

- Authorized penetration testing engagements
- Red team exercises with proper scope
- CTF competitions and wargames
- Security research and education
- Bug bounty programs

Never use these tools against systems without explicit authorization.

## Contributing

Contributions are welcome! To add a new plugin:

1. Create a directory under `plugins/your-plugin-name/commands/`
2. Add one or more `.md` files with the command prompts
3. Use `$ARGUMENTS` placeholder where user input should be inserted
4. Include clear instructions, methodology, and output format
5. Submit a pull request

## License

MIT License - see [LICENSE](LICENSE) for details.

---

**Built for the security community by [CyberSecurityUP](https://github.com/CyberSecurityUP)**
