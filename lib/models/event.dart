class Event {
  final String id;
  final String name;
  final String? iconUrl;
  final DateTime? deadline;
  final List<String> agentIds; // IDs of agents associated with this event
  final bool isCompleted;
  final String? category; // e.g., "Combat Simulation", "Specialization", etc.
  final Map<String, dynamic>? resources; // Resources associated with this event
  final int? daysRemaining;
  final int? hoursRemaining;

  Event({
    required this.id,
    required this.name,
    this.iconUrl,
    this.deadline,
    this.agentIds = const [],
    this.isCompleted = false,
    this.category,
    this.resources,
    this.daysRemaining,
    this.hoursRemaining,
  });

  Event copyWith({
    String? id,
    String? name,
    String? iconUrl,
    DateTime? deadline,
    List<String>? agentIds,
    bool? isCompleted,
    String? category,
    Map<String, dynamic>? resources,
    int? daysRemaining,
    int? hoursRemaining,
  }) {
    return Event(
      id: id ?? this.id,
      name: name ?? this.name,
      iconUrl: iconUrl ?? this.iconUrl,
      deadline: deadline ?? this.deadline,
      agentIds: agentIds ?? this.agentIds,
      isCompleted: isCompleted ?? this.isCompleted,
      category: category ?? this.category,
      resources: resources ?? this.resources,
      daysRemaining: daysRemaining ?? this.daysRemaining,
      hoursRemaining: hoursRemaining ?? this.hoursRemaining,
    );
  }
}