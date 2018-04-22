module.exports = {
  apps: [
    {
      script: 'app.js',
      watch: false,
      ignore_watch: ['logs'],
      //exec_mode: 'fork_mode',
      wait_ready: true,
      name: 'app-dev',
      instances: 1,
      error_file: './logs/app.err.log',
      out_file: './logs/app.out.log', 
      pid_file: './logs/app.pid', 
      listen_timeout: 30000,
      kill_timeout: 30000,
      env: {
        NODE_ENV: 'development',
      },
    },
  ]
};
