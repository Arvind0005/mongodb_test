import 'package:dart_mongo/dart_mongo.dart' as dart_mongo;
import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_dart/mongo_dart.dart';

main(List<String> arguments) async {
  Db db = Db('mongodb://localhost:27017/test');
  await db.open();
  print("connected");

  DbCollection coll = db.collection('people');
  //lets read the db:
  var people = await coll.findOne(where.match('first_name', 'a').gt('id', 90));
  print(people);
  //
  await db.close();
}
