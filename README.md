# My VPS

This is my Dockers and files for my VPS install and reinstall

> Tip: `git clone https://github.com/madpin/my-vps.git ~/server`

## Starting new Server:
Now on Debian 🥳

### Let's make sure everything is updates:

```bash
apt update
sudo apt install -y nano vim wget curl net-tools lsof
```

### Install Zsh

```bash
sudo apt install -y zsh
```

### Creating a New User
Please, don't use root, that's risky!  
I'll put my commands here, so replace `madpin` for your username.  

```bash
adduser madpin
passwd madpin
usermod -aG sudo madpin
```

Add the SSH Key for the user:


### Install and Configure RClone

I use 4 providers:  

- Goole Drive
  - `gdrive` as name
- Goole Drive Corporate (crypt)
- PCloud
  - `pcloud` as an name
  - `p` as an alias
- Mega
  - `mega` as an name

If you already have the config in another machine:  
```bash
rclone config file
```


<details><summary>Secret</summary>
I'm funny.  

![LOL Minion](static/images/lol-minion.gif)
</details>