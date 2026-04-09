# Tests

## Overview

| File | Language | Framework | What it tests |
|------|----------|-----------|---------------|
| `test_btrfs.py` | Python | pytest | `btrfs.py` — `_uuid_or_none` (dash/empty/whitespace/valid), `_parse_subvol_line` (standard/snapshot/path with spaces/FS_TREE prefix/too short/empty/missing path/missing ID/no cgen fallback), `_EXTENT_RE` regex (filefrag lines, header rejection, filename rejection) |
| `test_scanner.py` | Python | pytest | `scanner.py` — `_compute_transitions` (single creation/creation+unchanged/creation+modification/creation+deletion/nonexistent→created/all nonexistent/delete+recreate/consecutive nonexistent skipped), `_detect_modification` (size change/mtime change/no checksum/same checksum/different checksum/same all/type changed dir→file/checksum differs same size+mtime), `FileHistory` (created_in/modified_in/no creation), `find_shared_extents` (shared physical offset/no shared/inline extents skipped/zero offset/length skipped), renderer helpers (`_human_size`, `_truncate`, `_dot_id`, `_dot_escape`, `_color`), `differ` (`diff_states` — size delta/checksum identical/different/no checksum/shared extents) |
| `test_tree.py` | Python | pytest | `tree.py` — `_validate_relative` (normal path/leading slash stripped/traversal rejected/mid traversal rejected/empty/dot) |

## Running

```bash
# All tests
make test

# Individual suites
python -m pytest tests/test_btrfs.py -v
python -m pytest tests/test_scanner.py -v
python -m pytest tests/test_tree.py -v
```

## How they work

### Python tests

Standard pytest suites with class-based assertion groups (`TestClassName`). No system access — all dataclasses and pure functions are tested with synthetic data. No real btrfs filesystems, snapshots, or subprocess calls.

- **`test_btrfs.py`**: Tests line parsing functions for `btrfs subvolume list` output and extent regex matching. All inputs are hand-crafted strings.
- **`test_scanner.py`**: Tests the entire file history pipeline — transition detection (`created`/`modified`/`deleted`/`unchanged`/`type_changed`), modification detection with checksum logic, `FileHistory` queries (`created_in`, `modified_in`), shared extent analysis, and renderer helper functions (`_human_size`, `_truncate`, `_dot_id`, `_dot_escape`, `_color`).
- **`test_tree.py`**: Tests path validation — leading slash stripping, `..` traversal rejection.

## Test environment

- No root privileges required
- No real btrfs filesystems, snapshots, volumes, or system files are touched
- All test data is synthetic — no `tmp_path` needed since no file I/O occurs
