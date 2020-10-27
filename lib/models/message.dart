class Message {
    Message({
        this.from,
        this.to,
        this.message,
        this.createdAt,
        this.updatedAt,
    });

    String from;
    String to;
    String message;
    DateTime createdAt;
    DateTime updatedAt;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        from: json["_from"],
        to: json["_to"],
        message: json["message"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_from": from,
        "_to": to,
        "message": message,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}