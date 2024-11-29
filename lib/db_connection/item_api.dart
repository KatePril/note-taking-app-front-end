class ItemApi {
  ItemApi._internal();

  static final ItemApi _instance = ItemApi._internal();

  factory ItemApi() {
    return _instance;
  }
}