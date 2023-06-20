class ColorPalette {
  static Map<String, dynamic> red = {'name': 'Red', 'value': 0xFF0000};
  static Map<String, dynamic> green = {'name': 'Green', 'value': 0x00FF00};
  static Map<String, dynamic> blue = {'name': 'Blue', 'value': 0x0000FF};
  static Map<String, dynamic> yellow = {'name': 'Yellow', 'value': 0xFFFF00};
  static Map<String, dynamic> cyan = {'name': 'Cyan', 'value': 0x00FFFF};
  static Map<String, dynamic> magenta = {'name': 'Magenta', 'value': 0xFF00FF};
  static Map<String, dynamic> orange = {'name': 'Orange', 'value': 0xFFA500};
  static Map<String, dynamic> purple = {'name': 'Purple', 'value': 0x800080};
  static Map<String, dynamic> pink = {'name': 'Pink', 'value': 0xFFC0CB};
  static Map<String, dynamic> brown = {'name': 'Brown', 'value': 0x964B00};
  static Map<String, dynamic> gray = {'name': 'Gray', 'value': 0x808080};
  static Map<String, dynamic> navy = {'name': 'Navy', 'value': 0x000080};
  static Map<String, dynamic> olive = {'name': 'Olive', 'value': 0x808000};
  static Map<String, dynamic> silver = {'name': 'Silver', 'value': 0xC0C0C0};
  static Map<String, dynamic> aqua = {'name': 'Aqua', 'value': 0x00FFFF};
  static Map<String, dynamic> white = {'name': 'White', 'value': 0xFFFFFF};
  static Map<String, dynamic> black = {'name': 'Black', 'value': 0x000000};
  static Map<String, dynamic> beige = {'name': 'Beige', 'value': 0xF5F5DC};
  static Map<String, dynamic> tan = {'name': 'Tan', 'value': 0xD2B48C};
  static Map<String, dynamic> wheat = {'name': 'Wheat', 'value': 0xF5DEB3};
  static Map<String, dynamic> lavender = {
    'name': 'Lavender',
    'value': 0xE6E6FA
  };

  static Map<String, dynamic> gold = {'name': 'Gold', 'value': 0xFFD700};
  static Map<String, dynamic> silverGray = {
    'name': 'Silver Gray',
    'value': 0xC0C0C0
  };
  static Map<String, dynamic> lightPink = {
    'name': 'Light Pink',
    'value': 0xFFB6C1
  };
  static Map<String, dynamic> darkGray = {
    'name': 'Dark Gray',
    'value': 0xA9A9A9
  };
  static Map<String, dynamic> lightGray = {
    'name': 'Light Gray',
    'value': 0xD3D3D3
  };
  static Map<String, dynamic> mediumPurple = {
    'name': 'Medium Purple',
    'value': 0x9370DB
  };
  static Map<String, dynamic> lightBlue = {
    'name': 'Light Blue',
    'value': 0xADD8E6
  };
  static Map<String, dynamic> lightGreen = {
    'name': 'Light Green',
    'value': 0x90EE90
  };
  static Map<String, dynamic> indigo = {'name': 'Indigo', 'value': 0x4B0082};
  static Map<String, dynamic> darkRed = {'name': 'Dark Red', 'value': 0x8B0000};
  static Map<String, dynamic> darkGreen = {
    'name': 'Dark Green',
    'value': 0x006400
  };
  static Map<String, dynamic> darkBlue = {
    'name': 'Dark Blue',
    'value': 0x00008B
  };
  static Map<String, dynamic> darkCyan = {
    'name': 'Dark Cyan',
    'value': 0x008B8B
  };

  static Map<String, dynamic> darkOrange = {
    'name': 'Dark Orange',
    'value': 0xFF8C00
  };

  static Map<String, dynamic> darkYellow = {
    'name': 'Dark Yellow',
    'value': 0xFFD700
  };

  static Map<String, dynamic> darkTurquoise = {
    'name': 'Dark Turquoise',
    'value': 0x00CED1
  };
  static Map<String, dynamic> darkSlateGray = {
    'name': 'Dark Slate Gray',
    'value': 0x2F4F4F
  };
  static Map<String, dynamic> deepPink = {
    'name': 'Deep Pink',
    'value': 0xFF1493
  };

  static Map<String, dynamic> forestGreen = {
    'name': 'Forest Green',
    'value': 0x228B22
  };
  static Map<String, dynamic> hotPink = {'name': 'Hot Pink', 'value': 0xFF69B4};
  static Map<String, dynamic> mediumBlue = {
    'name': 'Medium Blue',
    'value': 0x0000CD
  };
  static Map<String, dynamic>? getColorByName(String colorName) {
    switch (colorName) {
      case 'Red':
        return ColorPalette.red;
      case 'Green':
        return ColorPalette.green;
      case 'Blue':
        return ColorPalette.blue;
      case 'Yellow':
        return ColorPalette.yellow;
      case 'Cyan':
        return ColorPalette.cyan;
      case 'Magenta':
        return ColorPalette.magenta;
      case 'Orange':
        return ColorPalette.orange;
      case 'Purple':
        return ColorPalette.purple;
      case 'Pink':
        return ColorPalette.pink;
      case 'Brown':
        return ColorPalette.brown;
      case 'Gray':
        return ColorPalette.gray;
      case 'Navy':
        return ColorPalette.navy;
      case 'Olive':
        return ColorPalette.olive;
      case 'Silver':
        return ColorPalette.silver;
      case 'Aqua':
        return ColorPalette.aqua;
      case 'White':
        return ColorPalette.white;
      case 'Black':
        return ColorPalette.black;
      case 'Beige':
        return ColorPalette.beige;
      case 'Tan':
        return ColorPalette.tan;
      case 'Wheat':
        return ColorPalette.wheat;
      case 'Lavender':
        return ColorPalette.lavender;
      case 'Gold':
        return ColorPalette.gold;
      case 'Silver Gray':
        return ColorPalette.silverGray;
      case 'Light Pink':
        return ColorPalette.lightPink;
      case 'Dark Gray':
        return ColorPalette.darkGray;
      case 'Light Gray':
        return ColorPalette.lightGray;
      case 'Medium Purple':
        return ColorPalette.mediumPurple;
      case 'Light Blue':
        return ColorPalette.lightBlue;
      case 'Light Green':
        return ColorPalette.lightGreen;
      case 'Indigo':
        return ColorPalette.indigo;
      case 'Dark Red':
        return ColorPalette.darkRed;
      case 'Dark Green':
        return ColorPalette.darkGreen;
      case 'Dark Blue':
        return ColorPalette.darkBlue;
      case 'Dark Cyan':
        return ColorPalette.darkCyan;
      case 'Dark Orange':
        return ColorPalette.darkOrange;
      case 'Dark Yellow':
        return ColorPalette.darkYellow;
      case 'Dark Turquoise':
        return ColorPalette.darkTurquoise;
      case 'Dark Slate Gray':
        return ColorPalette.darkSlateGray;
      case 'Deep Pink':
        return ColorPalette.deepPink;
      case 'Forest Green':
        return ColorPalette.forestGreen;
      case 'Hot Pink':
        return ColorPalette.hotPink;
      case 'Medium Blue':
        return ColorPalette.mediumBlue;
    }
    return null;
  }
}
