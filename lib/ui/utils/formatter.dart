import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' as html_parser;

class Formatter {
  const Formatter._(); // prevent instance

  // =====================
  // Currency
  // =====================
  static final currency = _CurrencyFormatter();

  // =====================
  // Date
  // =====================
  static final date = _DateFormatter();

  // =====================
  // HTML
  // =====================
  static final html = _HtmlFormatter();
}

/* =======================
   CURRENCY
======================= */
class _CurrencyFormatter {
  String rupiah(int number) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatCurrency.format(number);
  }

  String rupiahDouble(double number) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatCurrency.format(number);
  }

  String noRupiahDouble(double number) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: '',
      decimalDigits: 0,
    );
    return formatCurrency.format(number);
  }
}

/* =======================
   DATE
======================= */
class _DateFormatter {
  String dateTime(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      return DateFormat('dd MMM yyyy HH:mm', 'id_ID').format(dateTime);
    } catch (_) {
      return dateTimeString;
    }
  }

  String dateTimeFull(String dateTimeString) {
    try {
      final dateTimeUtc = DateTime.parse(dateTimeString).toUtc();
      final dateTimeWib = dateTimeUtc.add(const Duration(hours: 7));
      return DateFormat('dd/MM/yyyy HH:mm').format(dateTimeWib);
    } catch (_) {
      return dateTimeString;
    }
  }

  String date(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      return DateFormat('dd MMM yyyy', 'id_ID').format(dateTime);
    } catch (_) {
      return dateTimeString;
    }
  }

  String time(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      return DateFormat('HH:mm WIB').format(dateTime);
    } catch (_) {
      return dateTimeString;
    }
  }
}

/* =======================
   HTML
======================= */
class _HtmlFormatter {
  /// HTML ➜ plain text
  String toText(String? html) {
    if (html == null || html.isEmpty) return '';
    final document = html_parser.parse(html);
    return document.body?.text.trim() ?? '';
  }

  /// HTML ➜ Widget (CKEditor friendly)
  Widget render(String? html, {TextStyle? textStyle}) {
    if (html == null || html.isEmpty) {
      return const SizedBox();
    }

    final fontSize = textStyle?.fontSize ?? 14;
    final color = textStyle?.color;
    final fontFamily = textStyle?.fontFamily;

    return Html(
      data: html,
      style: {
        "*": Style(
          fontSize: FontSize(fontSize),
          color: color,
          fontFamily: fontFamily,
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
        ),
        "p": Style(margin: Margins.only(bottom: 8)),
        "ul": Style(
          padding: HtmlPaddings.zero,
          margin: Margins.zero,
          listStylePosition: ListStylePosition.inside,
        ),
        "ol": Style(
          padding: HtmlPaddings.zero,
          margin: Margins.zero,
          listStylePosition: ListStylePosition.inside,
        ),
        "li": Style(margin: Margins.only(bottom: 6)),
        "strong": Style(fontWeight: FontWeight.bold),
      },
    );
  }
}
