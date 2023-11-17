class BookingDetailsModel {
  final String userUid;
  final String slotBooked;
  final String astrologerId;

  BookingDetailsModel( {
    required this.userUid,
    required this.slotBooked,
    required this.astrologerId,
  });

  toJson() {
    return {
      'astrologer id':astrologerId,
      'user uid': userUid,
      'slot booked': slotBooked,
    };
  }
}
