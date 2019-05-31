import 'package:flutter/widgets.dart';


class TextStyles {
  static TextStyle listTitle = TextStyle(
    fontSize: 16.0,
    color: Color(0xFF333333),
    fontWeight: FontWeight.bold,
  );
  static TextStyle listContent = TextStyle(
    fontSize: 14.0,
    color: Color(0xFF666666),
  );
  static TextStyle listExtra = TextStyle(
    fontSize: 12.0,
    color: Color(0xFF999999),
  );
}

class Decorations {
  static Decoration bottom = BoxDecoration(
      border: Border(bottom: BorderSide(width: 0.33, color: Color(0xffe5e5e5))));
}
/// 间隔
class Gaps {
  /// 水平间隔
  static Widget hGap5 = new SizedBox(width: 5.0);
  static Widget hGap10 = new SizedBox(width: 10.0);
  static Widget hGap15 = new SizedBox(width: 15.0);

  /// 垂直间隔
  static Widget vGap5 = new SizedBox(height: 5.0);
  static Widget vGap10 = new SizedBox(height: 10.0);
  static Widget vGap15 = new SizedBox(height: 15.0);
}
