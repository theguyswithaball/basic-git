# Basic Git Claude Skill

This repository contains a Claude skill for basic Git usage and a helper hook that initializes a repo, writes a .gitignore, commits changes, and pushes to GitHub at conversation start.

## Install in a project

Copy the `basic-git` skill folder into your project’s Claude skills directory:

```bash
mkdir -p .claude/skills
cp -R basic-git .claude/skills/
```

## Configure the hook

Add a conversation-start hook to your project’s `.claude/settings.json`:

```json
{
  "hooks": {
    "ConversationStart": [
      {
        "matcher": "startup",
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PROJECT_DIR}/.claude/skills/basic-git/git-init-push.sh",
            "timeout": 60,
            "statusMessage": "Git: syncing project state..."
          }
        ]
      }
    ]
  }
}
```

## Skill usage

Once the skill is in `.claude/skills`, Claude can use it as a normal project skill.

## Repo contents

- `basic-git/skills/basic-git/SKILL.md` — the Git usage skill instructions
- `basic-git/bin/git-init-push.sh` — the hook script that runs on conversation start
- `basic-git/hooks/hooks.json` — example hook registration for a plugin setup
