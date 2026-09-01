#!/bin/bash
# Claude Code plugin hook — fires on SessionStart (new session only).
# Inits git, writes .gitignore, commits all files, and pushes to GitHub.
# Idempotent: skips git init if .git already exists; skips commit if nothing changed.

set -euo pipefail

# ─── CONFIG ───────────────────────────────────────────────────────────────────
GITHUB_TOKEN="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"
GITHUB_USER="theguyswithaball"
GITHUB_REPO="project"
REMOTE_URL="https://${GITHUB_TOKEN}@github.com/${GITHUB_USER}/${GITHUB_REPO}.git"
BRANCH="main"
COMMIT_MSG="chore: auto-commit on session start [$(date '+%Y-%m-%d %H:%M:%S')]"
# ──────────────────────────────────────────────────────────────────────────────

# Prevent running more than once per session (SessionStart fires once, but guard anyway)

cd "../"

# ── 1. git init ────────────────────────────────────────────────────────────────
if [[ ! -d ".git" ]]; then
  git init
  git branch -M "$BRANCH"
fi

# ── 2. Write .gitignore ────────────────────────────────────────────────────────
cat > .gitignore << 'GITIGNORE_EOF'
# Created by https://www.toptal.com/developers/gitignore/api/macos,python,node,venv,angular,java,yarn,localstack,visualstudiocode,pycharm+all,firebase,ats

### Angular ###
dist/
tmp/
app/**/*.js
app/**/*.js.map
node_modules/
bower_components/
.idea/
.sass-cache/
connect.lock/
coverage/
libpeerconnection.log/
npm-debug.log
testem.log
typings/
.angular/
e2e/*.js
e2e/*.map
.DS_Store/

### ATS ###
*~
*_?ats.c
*_?ats.o
*_?ats.js

### Firebase ###
.idea
**/node_modules/*
**/.firebaserc
.runtimeconfig.json
.firebase/

### Java ###
*.class
*.log
*.ctxt
.mtj.tmp/
*.jar
*.war
*.nar
*.ear
*.zip
*.tar.gz
*.rar
hs_err_pid*
replay_pid*

### LocalStack ###
**/.localstack

### macOS ###
.DS_Store
.AppleDouble
.LSOverride
Icon
._*
.DocumentRevisions-V100
.fseventsd
.Spotlight-V100
.TemporaryItems
.Trashes
.VolumeIcon.icns
.com.apple.timemachine.donotpresent
.AppleDB
.AppleDesktop
Network Trash Folder
Temporary Items
.apdisk
*.icloud

### Node ###
logs
npm-debug.log*
yarn-debug.log*
yarn-error.log*
lerna-debug.log*
.pnpm-debug.log*
report.[0-9]*.[0-9]*.[0-9]*.[0-9]*.json
pids
*.pid
*.seed
*.pid.lock
lib-cov
coverage
*.lcov
.nyc_output
.grunt
bower_components
.lock-wscript
build/Release
jspm_packages/
web_modules/
*.tsbuildinfo
.npm
.eslintcache
.stylelintcache
.rpt2_cache/
.rts2_cache_cjs/
.rts2_cache_es/
.rts2_cache_umd/
.node_repl_history
*.tgz
.yarn-integrity
.env
.env.development.local
.env.test.local
.env.production.local
.env.local
.cache
.parcel-cache
.next
out
.nuxt
dist
.cache/
.vuepress/dist
.temp
.docusaurus
.serverless/
.fusebox/
.dynamodb/
.tern-port
.vscode-test
.yarn/cache
.yarn/unplugged
.yarn/build-state.yml
.yarn/install-state.gz
.pnp.*
.webpack/
.svelte-kit

### PyCharm+all ###
.idea/**/workspace.xml
.idea/**/tasks.xml
.idea/**/usage.statistics.xml
.idea/**/dictionaries
.idea/**/shelf
.idea/**/aws.xml
.idea/**/contentModel.xml
.idea/**/dataSources/
.idea/**/dataSources.ids
.idea/**/dataSources.local.xml
.idea/**/sqlDataSources.xml
.idea/**/dynamic.xml
.idea/**/uiDesigner.xml
.idea/**/dbnavigator.xml
.idea/**/gradle.xml
.idea/**/libraries
cmake-build-*/
.idea/**/mongoSettings.xml
*.iws
out/
.idea_modules/
atlassian-ide-plugin.xml
.idea/replstate.xml
.idea/sonarlint/
com_crashlytics_export_strings.xml
crashlytics.properties
crashlytics-build.properties
fabric.properties
.idea/httpRequests
.idea/caches/build_file_checksums.ser
.idea/*
!.idea/codeStyles
!.idea/runConfigurations

### Python ###
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
share/python-wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST
*.manifest
*.spec
pip-log.txt
pip-delete-this-directory.txt
htmlcov/
.tox/
.nox/
.coverage
.coverage.*
nosetests.xml
coverage.xml
*.cover
*.py,cover
.hypothesis/
.pytest_cache/
cover/
*.mo
*.pot
local_settings.py
db.sqlite3
db.sqlite3-journal
instance/
.webassets-cache
.scrapy
docs/_build/
.pybuilder/
target/
.ipynb_checkpoints
profile_default/
ipython_config.py
.pdm.toml
__pypackages__/
celerybeat-schedule
celerybeat.pid
*.sage.py
.venv
env/
venv/
ENV/
env.bak/
venv.bak/
.spyderproject
.spyproject
.ropeproject
/site
.mypy_cache/
.dmypy.json
dmypy.json
.pyre/
.pytype/
cython_debug/
poetry.toml
.ruff_cache/
pyrightconfig.json

### venv ###
[Bb]in
[Ii]nclude
[Ll]ib
[Ll]ib64
[Ll]ocal
[Ss]cripts
pyvenv.cfg
pip-selfcheck.json

### VisualStudioCode ###
.vscode/*
!.vscode/settings.json
!.vscode/tasks.json
!.vscode/launch.json
!.vscode/extensions.json
!.vscode/*.code-snippets
.history/
*.vsix
.history
.ionide

### yarn ###
.yarn/*
!.yarn/releases
!.yarn/patches
!.yarn/plugins
!.yarn/sdks
!.yarn/versions

# End of https://www.toptal.com/developers/gitignore/api/macos,python,node,venv,angular,java,yarn,localstack,visualstudiocode,pycharm+all,firebase,ats
GITIGNORE_EOF

# ── 3. Stage all files ─────────────────────────────────────────────────────────
git add -A

# ── 4. Commit only if there are staged changes ─────────────────────────────────
if ! git diff --cached --quiet; then
  git -c user.email="claude-hook@local" -c user.name="Claude Hook" commit -m "$COMMIT_MSG"
fi

# ── 5. Set / update remote ─────────────────────────────────────────────────────
if git remote get-url origin &>/dev/null 2>&1; then
  git remote set-url origin "$REMOTE_URL"
else
  git remote add origin "$REMOTE_URL"
fi

# ── 6. Push ────────────────────────────────────────────────────────────────────
git push -u origin "$BRANCH" || git push --force-with-lease origin "$BRANCH"
