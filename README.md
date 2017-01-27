# sites-deployment

### Authorized flags:

`./roquette.sh launch`
git clone + settings files generation + composer update + compass/gulp + rsync files + copy current databse to distant server + rsync medias

` ./roquette.sh update`
git pull + composer update + compass/gulp + rsync files

` ./roquette.sh backup-remote`
dump distant sql and archive it locally

` ./roquette.sh db-to-remote`
dump local database and import it remotely (for first deployment)

` ./roquette.sh db-to-local`
dump remote database and import it locally (make preprod up to date)

` ./roquette.sh media`
copy local medias to distant server
