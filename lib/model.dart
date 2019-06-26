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
