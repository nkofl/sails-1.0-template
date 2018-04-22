module.exports = shipit => {
  // Load shipit-deploy tasks
  require('shipit-deploy')(shipit)
  require('shipit-npm')(shipit);
  require('shipit-shared')(shipit);
  var colors = require('colors/safe');
  var config = require('./config/passwords.json').shipit;

  shipit.initConfig({
    default: {
      repositoryUrl: config.repo,
      keepReleases: 6,
      shallowClone: true,
      ignores: ['.git', 'node_modules'],
      workspace: 'tmp',
      npm: {
        remote: true
      },
      shared: {
        overwrite: true,
        triggerEvent: 'npm_installed',
        dirs: [
          'logs',
        ], 
        files: [
          'config/local.js',
          'config/connections.js',
          'database.json'
        ],
      },
    },
    staging: config.staging,
    production: config.production
  });

  shipit.task('pwd', function () {
    return shipit.remote('pwd');
  });

  shipit.blTask('db-migrate', async () => {
    shipit.log('Migrating database.');
    var cdPath = shipit.releasePath || shipit.currentPath;
    return shipit.remote(
      'db-migrate --version && cd ' + cdPath + ' && db-migrate up'
    ).then(function () {
      shipit.log(colors.green('db-migrate complete'));
    })
    .then(function () {
      shipit.emit('db_migrated')
    })
    .catch(function (e) {
      shipit.log(colors.red(e));
    });
  });

  shipit.task('start', async () => {
    shipit.log('Restarting application using PM2.');
    var cdPath = shipit.releasePath || shipit.currentPath;
    let schema = shipit.config.pm2 && shipit.config.pm2.script ? shipit.config.pm2.script : 'ecosystem.config.js'
    let cmd = `NODE_ENV="${shipit.environment}" cd ${shipit.config.deployTo} && pm2 startOrReload ${schema}`

    return shipit.remote(cmd).then(function () {
      shipit.log(colors.green('PM2 restart complete'));
    })
    .catch(function (e) {
      shipit.log(colors.red(e));
    });
  });

  shipit.task('stop', async () => {
    shipit.log('Stopping application using PM2.');
    var cdPath = shipit.releasePath || shipit.currentPath;
    let schema = shipit.config.pm2 && shipit.config.pm2.script ? shipit.config.pm2.script : 'ecosystem.config.js'
    let cmd = `NODE_ENV="${shipit.environment}" cd ${shipit.config.deployTo} && pm2 delete ${schema}`

    return shipit.remote(cmd).then(function () {
      shipit.log(colors.green('PM2 shutdown complete'));
    })
    .catch(function (e) {
      shipit.log(colors.red(e));
    });
  });

  shipit.blTask('buildAssets', async () => {
    shipit.log('Building assets with grunt cluster');
    var cdPath = shipit.releasePath || shipit.currentPath;
    let schema = shipit.config.pm2 && shipit.config.pm2.script ? shipit.config.pm2.script : 'ecosystem.config.js'
    let cmd = `NODE_ENV="${shipit.environment}" cd ${shipit.config.deployTo}/current && grunt cluster`

    return shipit.remote(cmd).then(function () {
      shipit.log(colors.green('Asset build complete'));
    })
    .then(function () {
      shipit.emit('assetsBuilt')
    })
    .catch(function (e) {
      shipit.log(colors.red(e));
    });
  });

  shipit.on('sharedEnd', function() { 
    shipit.start('db-migrate') 
  })

  shipit.on('published', function() { 
    if(shipit.environment == 'production')
      shipit.start('buildAssets');
    else
      shipit.start('pm2');
  })

  shipit.on('assetsBuilt', function() { 
    shipit.start('pm2')
  })
}