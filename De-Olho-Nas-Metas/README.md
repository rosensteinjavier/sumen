# Installing DONM locally

This tutorial was built for Linux operating system on your Ubuntu 14.04 distribution, which does not mean it can not be installed
in another OS, but it is not covered on this document.

----

### mise en place

For running **De Olho nas Metas** (DONM for now on), you will need:

* Some expierence with Linux and internet connection
* postgres-9.3 with postgis or higher
* perl 5.16.3 or higher
* nginx or other webserver

## Installing on ubuntu 14.04

### [1] System Binaries

Execute this command as root:

> To login as `root` user you need run `sudo su` on your terminal

    # apt-get update;
    # apt-get install -y postgresql postgresql-contrib postgresql-9.3-postgis-2.1  postgresql-9.3-postgis-scripts build-essential bzip2 gzip less git  nginx libexpat1 libexpat1-dev libxml2-dev curl libpq-dev redis-server

With all above commands done, we already can configure PostgreSQL and nginx. But before we can install the Perl version 5.16.3.
The idea is to create a new a user only for this application and install the perl modules in an isolated environment.

### [2] Users and accounts

Execute this command as root:

    # adduser donm

> (Fill out the fields as you want; And remember the password!)

### [3] Downloading source code

The next command should be executed on user `donm`, if you are not sure how do that, open a new terminal and run:

    $ su donm
    
> always make sure you are $HOME when you su run `cd` to go to $HOME

After that, download the latest code from DONM or make a project fork (recommended).

    $ git clone https://github.com/eokoe/De-Olho-Nas-Metas.git

Go to the folder of the project:

    $ cd De-Olho-Nas-Metas;

Change to master (default), where the code is stable:

    $ git checkout master

### [4] Database configuration
Open a new terminal and type:

    $ sudo su
    # sed -Ei 's/md5/trust/g'  /etc/postgresql/9.3/main/pg_hba.conf; service postgresql reload

Now all your database accepts users without authentication on localhost. If you have any security knowledge, please configure as you needs.

> Type `exit` to exit the terminal session.

You can test if it worked running `psql -h 127.0.0.1 -U postgres` as an ordinary (non-root) user. Type `\q` to exit psql tool.

After that, you need create the database, in this case, we will name it `donm`

    $ createdb -h 127.0.0.1 -U postgres donm

DONM web needs an database too, for I18N, it called lexicon_database.
Next command will create the database, and then populate it with some keywords

    $ createdb -h 127.0.0.1 -U postgres lexicon_database
    $ gunzip -c /home/donm/De-Olho-Nas-Metas/web/data/lexicon_database.sql.gz | psql -h 127.0.0.1 -U postgres lexicon_database

### [5] Perl binary

All commands bellow should be executed on user `donm`:

    $ su donm

We will use the perlbrew to manage our perl version, run those commands on user donm:

    $ cd; curl -L http://xrl.us/perlbrewinstall | bash

Make perlbrew start at beginning of each the session:

    $ echo "source ~/perl5/perlbrew/etc/bashrc" >> ~/.bashrc

Make perlbrew start on current session:

    $ . ~/.bashrc

Install a module-manager called cpanm (CPAN Minus):

    $ perlbrew install-cpanm

For this project perl 5.16.3 version is being used, the following command installs this version of Perl and can take several minutes.

    $  perlbrew install perl-5.16.3 -n

After that, you need to switch the current version of perl using:

    $ perlbrew switch perl-5.16.3

All dependencies (packages) will be installed for the Perl version and chosen specifically for this user.

Let's try to install `DBD::Pg`, which depends on `pg_config` working (if not found, run `apt-get install libpq-dev` as root).

    $ cpanm DBD::Pg

### [6] Perl packages

Next command should be executed on user `donm`, on the project folder, if you are not sure, open a new terminal and run:

    $ su donm; cd De-Olho-Nas-Metas;

And now, you can install the perl packages that DONM needs:

    $ cpanm -n Module::Install Catalyst::Devel; cd api; cpanm -n installdeps .; cd ../web; cpanm -n installdeps .;

If any error show when installing, you may need to consult the generated log and search for the solution, which is usually related to installation of any necessary lib. If you are a clean installation, you should be fine.


### [7] Deploying DONM

This set should be executed on user `donm`, on the project folder, if you are not sure, open a new terminal and run:

    $ su donm; cd De-Olho-Nas-Metas;

First, let's create an directory for the logs:

    $ mkdir /home/donm/logs

Now you can execute `up_api.sh` and `up_web.sh`

up_api.sh will deploy the database (which by now, is empty) and then, up an HTTP server running on port 3060.
up_web.sh up an HTTP server running on port 5040.

    $ ./up_api.sh
    $ ./up_web.sh

Now you can browse to http://127.0.0.1:5040/ and see the homepage of DONM.

### [8] Configuring nginx as a reverse proxy

Copy misc/nginx-donm.conf to /etc/nginx/sites-available/default and reload; Execute this command as root:

    # cp /home/donm/De-Olho-Nas-Metas/misc/nginx-donm.conf  /etc/nginx/sites-available/default
    # service nginx restart

Please feel free for edit the file afterwards

----

# Web administration access
Default admin user is `admin@email.com` and it password is `12345`, you can login on http://localhost/login after installation and configuration of DONM.

Remember to change the password under http://localhost/admin/user/2 and http://localhost/admin/user/1.

WebAPI is a special user that cannot login, but is used to create new accounts. You may want to change it session key too, and reconfigure `api_user_api_key` on websmm.conf, then restart.


