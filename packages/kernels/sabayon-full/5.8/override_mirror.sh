
force_single_mirror () {
	local mirror=$1
  local repo="${2:-sabayonlinux.org}"

  # Temporary workaround for fetching data.
  echo "
[${repo}]
desc = Sabayon Linux Official Repository

repo = $mirror/entropy#bz2
pkg = $mirror/entropy
" > /etc/entropy/repositories.conf.d/entropy_$repo
}

force_single_mirror "http://sabayonlinux.mirror.garr.it/sabayon"
