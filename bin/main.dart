import 'package:dart_mongo/dart_mongo.dart' as dart_mongo;
import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongo_dart/mongo_dart.dart';

main(List<String> arguments) async {
  Db db = Db('mongodb://localhost:27017/test');
  await db.open();
  print("connected");

  DbCollection coll = db.collection('people');

  ///lets read the db:
  var people =
      await coll.find().toList(); //returns all the data in the collection

  //await coll.find(where.eq("first_name", "Hilton")).toList(); //returns datas whose first name equals to "Hilton";

  //await coll.findOne(where.gt('id', 40)); //returns one data whose id is greater than 40;

  //  await coll.findOne(where.jsQuery('''
  // return this.first_name.startsWith("A") && this.id > 10;
  // ''')); //returns one data whose firstname starts with "A", and id is greater than 10

  // print(people);

  ///lets create a new document in database called test collection called people.
  await coll.save({
    'id': 101,
    'first_name': 'Arvind',
    'email': 'arvindsuresh2002@gmail.com',
    'gender': 'male',
    'ip_address': '63.90.69.20',
  }); //this is how we save a new document

  // var people = await coll.findOne(where.eq('first_name', 'Arvind'));
  // print(people); // printing the document saved.

  ///lets update the document saved.

  await coll.update(await coll.findOne(where.eq('first_name', 'Arvind')), {
    r'$set': {
      'first_name': 'Arvind S',
    }
  }); // thats how we update a specific field in an document keeping other fields ideal

  // await coll.update(await coll.findOne(where.eq('first_name', 'Arvind')), {
  //     'first_name': 'Arvind S',
  // }); //this updates an whole document whose firstname is 'Arvind' to just one field  ie 'firstname' : 'Arvind';

  // print(await coll.findOne(where.eq('id', 101)));//print the updated document with its id.

  ///lets remove a document

  await coll.remove(await coll.findOne(where.eq('id', 101)));
  await coll
      .remove(where.eq('id', 101)); //removes all the document whose id is 101
  // people = await coll.find(where.eq('id', 101)).toList();
  // print(people); //it should print null;

  await db.close(); //it closes the db
}
