class Review {
  final int id;
  final int restaurant_id;
  final String user_name;
  final double rating;
  final String comment;
  final String created_at;

  Review({
    required this.id,
    required this.restaurant_id,
    required this.user_name,
    required this.rating,
    required this.comment,
    required this.created_at,
  });
}