import 'dart:async';

import 'package:logging/logging.dart';
import 'dart:developer';

/// Manager for logging in the *betrayal* package.
///
/// All of the functions and fields are static.
/// However, since static stuff is lazy in Dart,
/// [BetrayalPlugin] creates a singleton instance
/// to initialize everything.
class BetrayalLogConfig {
  /// Retrieves the singleton instance.
  factory BetrayalLogConfig() => _instance;

  static final _instance = BetrayalLogConfig._internal();

  static final Logger _logger = Logger("betrayal");

  BetrayalLogConfig._internal() {
    onRecord = (LogRecord record) {
      log(record.message,
          level: record.level.value,
          name: record.loggerName,
          sequenceNumber: record.sequenceNumber,
          time: record.time,
          error: record.error,
          stackTrace: record.stackTrace,
          zone: record.zone);
    };
    _logger.info("ready to log!");
  }

  static Level _level = Logger.root.level;

  /// Allows individual loggers to have their own level.
  ///
  /// In this case, you could use it to make *betrayal* shut up, for example.
  /// ```dart
  /// BetrayalLogConfig.allowIndividualLevels();
  /// BetrayalLogConfig().setLevel(Level.OFF);
  /// ```
  ///
  /// This function is implemented as
  /// ```
  /// static void allowIndividualLevels() => hierarchicalLoggingEnabled = true;
  /// ```
  /// so unfortunately, it's changing a global variable from the `logging` package.
  static void allowIndividualLevels() => hierarchicalLoggingEnabled = true;

  /// Use this to change the logging level `betrayal` scope.
  ///
  /// This is only possible, if `hierarchicalLoggingEnabled == true`.
  ///
  /// If the global isn't in scope,
  /// you can call [BetrayalLogConfig.allowIndividualLevels] instead.
  ///
  /// Valid input types are [Level], [String] and [num].
  ///
  /// | String | num |
  /// |-------|----|
  /// | `ALL` | 0 |
  /// | `FINEST` | 300 |
  /// | `FINER` | 400 |
  /// | `FINE` | 500 |
  /// | `CONFIG` | 700 |
  /// | `INFO` | 800 |
  /// | `WARNING` | 900 |
  /// | `SEVERE` | 1000 |
  /// | `SHOUT` | 1200 |
  /// | `OFF` | 2000 |
  static set level(dynamic level) {
    if (level is Level) {
      _level = level;
    } else if (level is String) {
      level = level.toUpperCase();
      _level = Level.LEVELS.firstWhere(
        (element) => element.name == level,
        orElse: () =>
            throw ArgumentError.value(level, "level", "not a valid Level!"),
      );
    } else if (level is num) {
      // This works assuming that the order will not be changed
      // from lowest value (ALL) to highest (OFF) in the future.
      _level = Level.LEVELS.lastWhere((element) => element.value <= level);
    } else {
      throw ArgumentError(
          "level must be a Level, String or num, not ${level.runtimeType}!");
    }
    _logger.level = _level;
    _logger.info("logging level changed to ${_level.name}");
  }

  /// The current logging level for the `betrayal` scope.
  static Level get level => _level;

  // ignore: prefer_function_declarations_over_variables
  static late void Function(LogRecord record) _onRecord;

  static StreamSubscription<LogRecord>? _subscription;

  /// Handles log records.
  ///
  /// Per default they will be send to `developer.log`,
  /// which is the default logging facility in Dart.
  static set onRecord(void Function(LogRecord record) onRecord) {
    _onRecord = onRecord;
    _subscription?.cancel();
    _subscription = _logger.onRecord.listen(_onRecord);
  }
}
