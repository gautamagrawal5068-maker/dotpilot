# DotPilot

DotPilot is a collection of small terminal tools built with Bash. I started working on it to make everyday file management a little easier and to learn more about working with shell scripts along the way.

Instead of running separate commands for different tasks, DotPilot brings a few of them together in one place.

## What it does

- **Organise** - Sort files into folders based on their file types.
- **Find duplicates** - Find duplicate files by comparing their SHA-256 hashes.
- **Inspect** - Get a quick look at a directory, including its files and folders.
- **Version** - Check the current version of DotPilot.

## Usage

```bash
./dotpilot.sh help
```

### Organise files

```bash
./dotpilot.sh organise ~/Downloads
```

### Find duplicates

```bash
./dotpilot.sh duplicates ~/Downloads
```

### Inspect a directory

```bash
./dotpilot.sh inspect
```

### Check version

```bash
./dotpilot.sh version
```

## Requirements

- Bash
- macOS or Linux

## A little about the project

DotPilot is something I'm building and improving as I learn. It's a small project for now, but I plan to add more useful terminal tools to it over time.

Made by Gautam.
