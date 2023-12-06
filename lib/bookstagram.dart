List<Event> EventList = [];

class Event {
  final String nama_event;
  final String tanggal_pelaksanaan;
  final int harga;
  final String foto;

  Event({required this.nama_event, required this.harga, required this.tanggal_pelaksanaan, required this.foto});
}