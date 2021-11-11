syncToRDM <- function() {
  if (!file.exists('~/result')) {
    message('~/result directory not exists.\n')
    return(FALSE)
  }
  jh_env = fromJSON('~/.config/grdm/env.json')
  jh_user = jh_env['JUPYTERHUB_USER']
  jh_server_name = jh_env['JUPYTERHUB_SERVER_NAME']
  yyyymmdd = format(Sys.time(), '%Y%m%d')
  to_path = sprintf('/mnt/rdm/osfstorage/result-%s-%s-%s/', jh_user, yyyymmdd, jh_server_name)
  cat(sprintf('Syncing...: ~/result -> %s\n', to_path))
  if (!dir.exists(to_path)) {
    dir.create(to_path)
  }
  r = file.copy(from = list.files('~/result/', full.names = TRUE), to = to_path, recursive = TRUE)
  if (r) {
    cat('Completed.\n')
  } else {
    message('Failed.\n')
  }
  return(r)
}
