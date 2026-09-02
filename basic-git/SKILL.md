---
name: basic-git
description: 'Basic Git usage — initialize repos, stage and commit changes, push/pull remotes, manage branches, inspect history. Use when: setting up a git repo, committing code, resolving merge conflicts, working with remotes, branching, viewing logs, or running git operations.'
argument-hint: 'Describe the git task you need help with'
---

# Basic Git Usage

## When to Use
- Initializing a new git repository
- Staging files and committing changes
- Pushing to or pulling from a remote
- Creating, switching, or merging branches
- Viewing status, diffs, and commit history
- Resetting or reverting changes

---

## Core Workflows

### Initialize a Repository

```bash
git init                        # Initialize in current directory
git init <directory>            # Initialize in a named directory
```

After init, add a remote and make the first commit:

```bash
git remote add origin <url>
git add .
git commit -m "Initial commit"
git push -u origin main
```

---

### Stage and Commit

```bash
git status                      # See what has changed
git diff                        # See unstaged changes
git add <file>                  # Stage a specific file
git add .                       # Stage all changes
git commit -m "message"         # Commit with a message
git commit --amend              # Amend the last commit (unpushed only)
```

**Good commit message format:**
```
<type>: short summary (50 chars max)

Optional longer description after a blank line.
```
Types: `feat`, `fix`, `chore`, `docs`, `refactor`, `test`

---

### Push and Pull

```bash
git push                        # Push current branch to its upstream
git push origin <branch>        # Push a specific branch
git push -u origin <branch>     # Set upstream and push
git pull                        # Fetch + merge from upstream
git pull --rebase               # Fetch + rebase (cleaner history)
git fetch                       # Fetch without merging
```

---

### Branches

```bash
git branch                      # List local branches
git branch -a                   # List all branches (including remote)
git branch <name>               # Create a new branch
git checkout <name>             # Switch to a branch
git checkout -b <name>          # Create and switch in one step
git switch <name>               # Modern alternative to checkout
git switch -c <name>            # Create and switch (modern)
git merge <branch>              # Merge branch into current
git branch -d <name>            # Delete a merged branch
git branch -D <name>            # Force delete a branch
```

---

### Inspect History and State

```bash
git log --oneline               # Compact commit log
git log --oneline --graph       # Visual branch graph
git show <commit>               # Show a specific commit
git diff <branch1>..<branch2>   # Diff between branches
git blame <file>                # Show who changed each line
```

---

### Undo and Reset

```bash
git restore <file>              # Discard unstaged changes to a file
git restore --staged <file>     # Unstage a file
git reset HEAD~1                # Undo last commit, keep changes staged
git reset --hard HEAD~1         # Undo last commit, discard changes (destructive)
git revert <commit>             # Create a new commit that undoes a commit
```

> **Warning:** `git reset --hard` and `git push --force` are destructive. Confirm with the user before running these.

---

### Remotes

```bash
git remote -v                   # List remotes with URLs
git remote add <name> <url>     # Add a remote
git remote set-url origin <url> # Change the remote URL
git remote remove <name>        # Remove a remote
```

---

### Stash

```bash
git stash                       # Stash current uncommitted changes
git stash list                  # List all stashes
git stash pop                   # Apply the latest stash and remove it
git stash drop                  # Discard the latest stash
```

---

### Tags

```bash
git tag                         # List tags
git tag <name>                  # Create a lightweight tag
git tag -a <name> -m "msg"      # Create an annotated tag
git push origin <name>          # Push a tag to remote
git push origin --tags          # Push all tags
```

---

## Safety Rules

1. Never `git push --force` on shared branches (e.g., `main`, `develop`) without explicit user confirmation.
2. Never `git reset --hard` without confirming the user has no uncommitted work they want to keep.
3. When resolving merge conflicts, show the diff to the user before completing the merge.
4. If a push is rejected, prefer `git pull --rebase` over a force push.
5. Never hardcode credentials (tokens, passwords) in scripts — use environment variables instead.

---

## Common Errors and Fixes

| Error | Fix |
|-------|-----|
| `fatal: not a git repository` | Run `git init` or navigate to the repo root |
| `rejected — non-fast-forward` | Run `git pull --rebase` then retry push |
| `CONFLICT (content): Merge conflict in <file>` | Open the file, resolve markers, then `git add <file> && git commit` |
| `detached HEAD state` | Run `git switch <branch>` to reattach |
| `error: src refspec main does not match any` | Make an initial commit before pushing |
