syncToRDM <- function() {
  if (!file.exists('~/result')) {
    message('~/result directory not exists.\n')
    return(FALSE)
  }
  jh_env = fromJSON('~/.config/grdm/env.json')
  jh_user = jh_env['JUPYTERHUB_USER']
  jh_server_name = jh_env['JUPYTERHUB_SERVER_NAME']
  binder_repo_url <- jh_env[['BINDER_REPO_URL']]
  yyyymmdd = format(Sys.time(), '%Y%m%d')
  storage_provider <- strsplit(binder_repo_url, "/")[[1]][5]
  to_path <- sprintf('/mnt/rdm/%s/result-%s-%s-%s/', storage_provider, jh_user, yyyymmdd, jh_server_name)
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
