# frozen_string_literal: true

max_threads_count = ENV.fetch('FL_RUBY_PUMA_MAX_THREADS', 5)
min_treads_count = 2
threads min_treads_count, max_threads_count

worker_timeout 60

port ENV.fetch('FL_RUBY_PUMA_PORT', 3000)

environment ENV.fetch('RAILS_ENV', 'development')

pidfile ENV.fetch('FL_RUBY_PUMA_PID', 'tmp/pids/server.pid')

# workers ENV.fetch("WEB_CONCURRENCY") { 2 }

plugin :tmp_restart
