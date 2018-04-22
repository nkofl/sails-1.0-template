When you see things in < >, replace that with a username or password or whatever, and get rid of the < >

Install ubuntu 16.04 server, and include ssh. Otherwise just defaults

Install additional packages
  curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
  sudo apt-get install -y nodejs build-essential postgresql git samba redis-server postfix

Set up postgresql
  sudo -u postgres createuser <USERNAME>
  sudo -u postgres createdb <DBNAME>
  sudo -u postgres psql
    alter user <USERNAME> with encrypted password '<some password>';
    grant all privileges on database <DBNAME> to <USERNAME>;
    \q
  sudo vi /etc/postgresql/9.5/main/pg_hba.conf
    Add records for the networks you want to allow in. For example:
      host    all             all             192.168.231.0/24        md5
      host    all             all             192.168.232.0/24        md5
      host    all             all             192.168.234.0/24        md5
  sudo vi /etc/postgresql/9.5/main/postgresql.conf
    uncomment and modify:
      listen_addresses = '*' 
  sudo service postgresql restart
 
Create working directory
  sudo mkdir /apps
  sudo chgrp users /apps
  sudo chmod g+w /apps
  sudo usermod -aG users <username>
  sudo usermod -g users <username>

Set up samba (for dev box only)
  sudo smbpasswd -a <username>
  sudo vi /etc/samba/smb.conf
    set:
      workgroup = <whatever>
      netbios name = <hostname>
      obey pam restrictions = no

    add:
      [apps]
        path = /apps
        read only = no
        create mask = 0664
        directory mask = 0775
        force create mode = 0020
        force directory mode = 0020
  sudo service smbd restart

update npm and install sails
  sudo npm install -g npm sails db-migrate db-migrate-pg shipit-cli pm2

Set up git
  git config --global user.name "<your name>"
  git config --global user.email "<your email>"
  
Clone repo - starting new project from template
  cd /apps
  git clone <PATH TO REPO>
  mv <templatedir> <newdir>
  cd <newdir>
  rm -rf .git
  git init
  npm install
  =================================================
  To set up for your app, edit:
    config/connections.coffee
      Set database name and credentials
    config/env/production.coffee
      Set database name
    config/env/staging.coffee
      Set database name
    ecosystem_production.js
      Set name
    ecosystem_staging.js
      Set name
    ecosystem.js
      Set name
    package.json
      set name, repo
    shipit-private.json
      Set repo and servers
    tasks/pipeline.js
      set global name, rename main style scss as needed
    views/auth/required.pug
      Set title, brand label
    views/layout.pug
      Set title, brand label
    database.json
      set database, username, password
  db-migrate up (or restore a database)

Clone repo - deploy existing project
  cd /apps
  git clone <PATH TO REPO>
  cd <newdir>
  npm install
  To set up for your app, edit:
    config/connections.coffee
      Set database name and credentials
    shipit-private.json
      Set repo and servers
    database.json
      set database, username, password
  db-migrate up (or restore a database)


On production machine
  sudo adduser deploy
  sudo usermod -aG users deploy
  sudo usermod -g users deploy
  sudo mkdir /apps
  sudo chgrp users /apps
  sudo su deploy
  cd /apps
  mkdir live
  mkdir live/production
  mkdir live/staging
  mkdir live/production/shared
  mkdir live/staging/shared
Copy untracked files into shared, edit as needed
edit ~/.ssh/authorized_keys, add your key
edit ~/.ssh/config on your dev box, add deploy@production key
  
  
