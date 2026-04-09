---
title: BTRFS-FILE-HISTORY
section: 8
header: System Administration
footer: btrfs-file-history
---

# NAME

btrfs-file-history — visualize file and directory lifecycle across btrfs snapshots

# SYNOPSIS

**btrfs-file-history** [*options*] **tree** *MOUNT_POINT*

**btrfs-file-history** [*options*] **history** *MOUNT_POINT* *FILE_PATH*

**btrfs-file-history** [*options*] **diff** *MOUNT_POINT* *FILE_PATH* *SNAP_OLD* *SNAP_NEW*

# DESCRIPTION

**btrfs-file-history** tracks how files and directories change across btrfs
snapshots. It can display the full subvolume tree, show a file's history
timeline (creation, modifications, deletions), and diff a file between two
specific snapshots.

File state detection uses size, mtime, optional checksums, and shared extent
analysis to distinguish actual content changes from metadata-only updates.

# COMMANDS

**tree** *MOUNT_POINT*
:   Show the btrfs subvolume tree. *MOUNT_POINT* is the filesystem root.
    Use **\--format** to output as text (default), Graphviz DOT, or JSON.

**history** *MOUNT_POINT* *FILE_PATH*
:   Show file history across all snapshots. *FILE_PATH* can be absolute
    (e.g. `/home/user/file`) or relative to the subvolume root.
    Use **\--checksum** for content-based change detection.
    Use **\--extents** to analyze shared physical extents.
    Use **\--du** to compute shared/exclusive bytes.
    Use **\--no-tree** to suppress the subvolume tree output.
    Use **\--filter** *PATTERN* to limit scanning to specific subvolumes.

**diff** *MOUNT_POINT* *FILE_PATH* *SNAP_OLD* *SNAP_NEW*
:   Diff a file between two snapshots. Prints size delta, content equality,
    shared extent count, and text diff.

# OPTIONS

**\--no-color**
:   Disable colored output.

**\--format** *FORMAT*
:   Output format for **tree** and **history**: `text` (default), `dot`,
    or `json`.

**\--checksum**
:   Compute checksums for accurate change detection (**history** only).

**\--extents**
:   Analyze shared physical extents via filefrag (**history** only).

**\--du**
:   Compute shared/exclusive bytes via btrfs du (**history** only).

**\--no-tree**
:   Don't show subvolume tree, only the timeline (**history** only).

**\--filter** *PATTERN* [*PATTERN*...]
:   Only scan subvolumes matching the given pattern(s) (**history** only).

**-h**, **\--help**
:   Show usage summary and exit.

**-V**, **\--version**
:   Print version and exit.

# EXIT STATUS

**0**
:   Success.

**1**
:   Error. Common causes: not a btrfs filesystem, path not found, permission
    denied, invalid snapshot references.

# FILES

**~/.local/state/btrfs-file-history/\***
:   State files.

# SEE ALSO

**btrfs-subvolume**(8), **btrfs-filetype**(8)
