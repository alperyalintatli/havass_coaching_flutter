class Logs {
  Logs({List<Log> log}) {
    this._log = log;
  }

  List<Log> _log;
  List<Log> get log => this._log;

  set log(List<Log> value) => this._log = value;
  Map map = Map();

  factory Logs.fromMap(Map<String, dynamic> data) => Logs(
        log: data['log'] != null
            ? (data['log'] as List).map((data) => Log.fromMap(data)).toList()
            : null,
      );

  Map<String, dynamic> toMap() => {
        "log": this._log != null
            ? this._log.map((e) {
                return {
                  "logId": e.logId,
                  "logStatus": e.logStatus,
                  "methodName": e.methodName,
                  "className": e.className,
                  "logDate": e.logDate,
                  "exception": e.exception,
                  "userEmail": e.userEmail
                };
              }).toList()
            : null
      };
}

class Log {
  Log(
      {String logId,
      String logStatus,
      String methodName,
      String className,
      DateTime logDate,
      String exception,
      String userEmail}) {
    this._logId = logId;
    this._logStatus = logStatus;
    this._methodName = methodName;
    this._className = className;
    this._logDate = logDate;
    this._exception = exception;
    this._userEmail = userEmail;
  }
  String _logId;
  String get logId => this._logId;

  set logId(String value) => this._logId = value;

  String _userEmail;
  String get userEmail => this._userEmail;

  set userEmail(String value) => this._userEmail = value;

  String _logStatus;
  String get logStatus => this._logStatus;

  set logStatus(String value) => this._logStatus = value;

  String _methodName;
  String get methodName => this._methodName;

  set methodName(String value) => this._methodName = value;

  String _className;
  String get className => this._className;

  set className(String value) => this._className = value;

  DateTime _logDate;
  DateTime get logDate => this._logDate;

  set logDate(DateTime value) => this._logDate = value;

  String _exception;
  String get exception => this._exception;

  set exception(String value) => this._exception = value;

  factory Log.fromMap(Map<String, dynamic> data) => Log(
      logId: data["logId"],
      logStatus: data["logStatus"],
      methodName: data["methodName"],
      className: data["className"],
      logDate: data["logDate"].toDate(),
      exception: data["exception"],
      userEmail: data["userEmail"]);

  Map<String, dynamic> toMap() => {
        "logId": this._logId,
        "logStatus": this._logStatus,
        "methodName": this._methodName,
        "className": this._className,
        "logDate": this._logDate,
        "exception": this._exception,
        "userEmail": this._userEmail
      };
}

class LogStatus {
  static const String WARNING = "Warning";
  static const String INFO = "Info";
}
