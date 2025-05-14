enum MovieCategory {
  featured('가장 인기있는'),
  nowPlaying('현재 상영중'),
  popular('인기순'),
  topRated('평점 높은순'),
  upcoming('개봉예정');

  final String label;
  const MovieCategory(this.label);
}