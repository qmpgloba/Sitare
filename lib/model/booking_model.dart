class BookingDetailsModel {
  final String userUid;
  final String slotBooked;

  BookingDetailsModel({
    required this.userUid,
    required this.slotBooked,
  });

  toJson() {
    return {
      'user uid': userUid,
      'slot booked': slotBooked,
    };
  }
}
