import 'package:intl/intl.dart';

class StringUtil {
  static String formatCurrency(double price) {
    final formatter = new NumberFormat("###,###.###", "vi");
    return '${formatter.format(price)}đ';
  }

  static int getIdFromString(String id) {
    id = id.replaceAll(',', '');
    return int.parse(id);
  }

  static double getPriceFromString(String price) {
    if(price.isEmpty) return 0;
    price = price.replaceAll('.', '');
    price = price.replaceAll('đ', '');
    return double.parse(price);
  }
}
