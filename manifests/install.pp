class monit::install {

  package {'monit':
    ensure  => latest,
  }

}
