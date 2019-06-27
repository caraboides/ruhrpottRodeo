class Event {
  final String bandName;
  final String id;
  final String stage;
  final String description;
  final DateTime start;
  final DateTime end;

  Event({
    this.bandName,
    this.id,
    this.stage,
    this.description,
    this.start,
    this.end,
  });
}

class Faq {
  final String question;
  final String answer;

  Faq({
    this.question,
    this.answer,
  });
}

class BandData {
  final String id;
  final String name;
  final String spotify;
  final String image;
  final String text;
  BandData({
    this.id,
    this.name,
    this.spotify,
    this.image,
    this.text,
  });
}