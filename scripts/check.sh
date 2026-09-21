#!/usr/bin/env bash
# Lints instruction files. Stdlib Python only; no network.
set -euo pipefail
cd "$(dirname "$0")/.."
python3 - <<'PY'
from pathlib import Path
import re, sys
root = Path('.')
errors = []
agents = list((root / 'agents').glob('*.md'))
if len(agents) != 7:
    errors.append(f'expected 7 agents, found {len(agents)}')
writers = []
for p in agents:
    text = p.read_text()
    if 'writes_to_broker: true' in text:
        writers.append(p.name)
    if '## Bot profile' not in text or '## System prompt' not in text:
        errors.append(f'{p}: missing Bot profile or System prompt')
    if '**Name:**' not in text or '**Job:**' not in text or '**Description:**' not in text:
        errors.append(f'{p}: profile card incomplete')
if writers != ['robin.md']:
    errors.append(f'one-writer rule: expected only robin.md writes, got {writers}')
for d in sorted((root / 'skills').iterdir()):
    if not d.is_dir():
        continue
    skill = d / 'SKILL.md'
    if not skill.exists():
        errors.append(f'missing {skill}')
        continue
    body = skill.read_text()
    m = re.search(r'^name:\s*(.+)$', body, re.M)
    if not m or m.group(1).strip() != d.name:
        errors.append(f'{skill}: name frontmatter must match directory {d.name}')
    dm = re.search(r'^description:\s*(.+)$', body, re.M)
    if dm and len(dm.group(1)) > 1024:
        errors.append(f'{skill}: description too long')
bad = re.compile(r'HOLD-TO-NEXT-CLOSE|staged \$5k|premarket gap|batman-ndx-pm', re.I)
for p in root.rglob('*'):
    if p.is_file() and p.suffix in {'.md', '.json', '.mdc'} and '.git' not in p.parts:
        t = p.read_text(errors='ignore')
        if bad.search(t):
            errors.append(f'{p}: contains banned strategy-playbook content')
for req in ['README.md', 'SETUP.md', 'LICENSE', 'SECURITY.md', 'CONTRIBUTING.md',
            'docs/ARCHITECTURE.md', 'docs/FAQ.md', 'docs/PROVENANCE.md', 'docs/HYPERLIQUID-ORIGIN.md']:
    if not (root / req).exists():
        errors.append(f'missing {req}')
if errors:
    print('FAIL')
    for e in errors:
        print(' -', e)
    sys.exit(1)
print('OK: agents, skills, one-writer, no strategy playbook keywords')
PY
