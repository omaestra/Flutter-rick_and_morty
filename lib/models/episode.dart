class Episode {
  final int id;
  final String name;
  final String airDate;
  final String episode;
  final String url;
  final String created;

  Episode({
    this.id,
    this.name,
    this.airDate,
    this.episode,
    this.url,
    this.created
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      name: json['name'],
      airDate: json['air_date'],
      episode: json['episode'],
      url: json['url'],
      created: json['created'],
    );
  }
}