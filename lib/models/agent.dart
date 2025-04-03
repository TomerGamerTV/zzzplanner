class Agent {
  final String id;
  final String name;
  final String avatarUrl;
  final String? rarity; // M0, M1, M2, M6, etc.
  final List<String> elements; // Elements/attributes the agent has
  final int level;
  final int? goalLevel;
  final Map<String, dynamic>? skills;
  final Map<String, dynamic>? resources;

  Agent({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.rarity,
    this.elements = const [],
    this.level = 1,
    this.goalLevel,
    this.skills,
    this.resources,
  });

  Agent copyWith({
    String? id,
    String? name,
    String? avatarUrl,
    String? rarity,
    List<String>? elements,
    int? level,
    int? goalLevel,
    Map<String, dynamic>? skills,
    Map<String, dynamic>? resources,
  }) {
    return Agent(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      rarity: rarity ?? this.rarity,
      elements: elements ?? this.elements,
      level: level ?? this.level,
      goalLevel: goalLevel ?? this.goalLevel,
      skills: skills ?? this.skills,
      resources: resources ?? this.resources,
    );
  }
}