

import 'dart:convert';

CategoryApiRsponse categoryApiRsponseFromJson(String str) => CategoryApiRsponse.fromJson(json.decode(str));

String categoryApiRsponseToJson(CategoryApiRsponse data) => json.encode(data.toJson());

class CategoryApiRsponse {
    String? status;
    List<Source>? sources;

    CategoryApiRsponse({
        this.status,
        this.sources,
    });

    factory CategoryApiRsponse.fromJson(Map<String, dynamic> json) => CategoryApiRsponse(
        status: json["status"],
        sources: json["sources"] == null ? [] : List<Source>.from(json["sources"]!.map((x) => Source.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "sources": sources == null ? [] : List<dynamic>.from(sources!.map((x) => x.toJson())),
    };
}

class Source {
    String? id;
    String? name;
    String? description;
    String? url;
    Category? category;
    Language? language;
    String? country;

    Source({
        this.id,
        this.name,
        this.description,
        this.url,
        this.category,
        this.language,
        this.country,
    });

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        url: json["url"],
        category: categoryValues.map[json["category"]],
        language: languageValues.map[json["language"]],
        country: json["country"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "url": url,
        "category": categoryValues.reverse[category],
        "language": languageValues.reverse[language],
        "country": country,
    };
}

enum Category {
    SPORTS
}

final categoryValues = EnumValues({
    "sports": Category.SPORTS
});

enum Language {
    EN,
    ES,
    FR
}

final languageValues = EnumValues({
    "en": Language.EN,
    "es": Language.ES,
    "fr": Language.FR
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
