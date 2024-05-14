# ButBucket bug OAUTH20-2488

This repository holds scipts and data relared to finding Bitbucket versions affected by bug 
[OAUTH20-2488](https://jira.atlassian.com/browse/OAUTH20-2488)

## Affected Versions

| BitBucket | Unaffected | Affected |
|----------|----------|----------|
| <= 8.7.x | all | --  |
| 8.8.x | 8.8.0 to 8.8.6 | 8.8.7  |
| 8.9.x | 8.9.0 to 8.9.3 | 8.9.4 to 8.9.14 |
| 8.10.x | 8.10.0 to 8.10.3 | 8.10.4 to 8.10.6 |
| 8.11.x | 8.11.0 to 8.11.2 | 8.11.3 to 8.11.6 |
| 8.12.x | 8.12.0 | 8.12.1 to 8.12.6 |
| >= 8.13.x | -- | all |


## Reproduce

Run `./check.sh 1.2.3` to check if a specific version is affected

Run `./check-all file.txt` to check if version from file.txt are affected. Each line from the file is treated as one version. 