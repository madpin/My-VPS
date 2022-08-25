# Bash Alias:

```bash
alias vps='ssh madpin@host.docker.internal -p2222'
alias host='ssh madpin@host.docker.internal -p2222'
alias ssd='ssh -t madpin@host.docker.internal -p22 "cd $(pwd | sed -r '"'"'s/^\/host_home+/~/g'"'"' | sed -r '"'"'s/^\/host_root+//g'"'"'); exec \$SHELL -l"'
```