#!/bin/bash
# Setup pre-push hook untuk mencegah push langsung ke main

REPO_ROOT=$(git rev-parse --show-toplevel)
HOOK_DIR="$REPO_ROOT/.git/hooks"
HOOK_FILE="$HOOK_DIR/pre-push"

cat > "$HOOK_FILE" << 'HOOK'
#!/bin/bash
protected_branch="main"
current_branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')

if [ "$current_branch" = "$protected_branch" ]; then
    echo "❌ ERROR: Push langsung ke '$protected_branch' dilarang!"
    echo "👉 Buat branch fitur dan buat Pull Request."
    exit 1
fi
exit 0
HOOK

chmod +x "$HOOK_FILE"
echo "✅ Pre-push hook berhasil di-setup!"
